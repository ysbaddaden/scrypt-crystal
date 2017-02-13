require "secure_random"
require "./lib_scrypt"

module Scrypt
  module Engine
    def self.hash_secret(secret,
                         salt,
                         key_len = DEFAULT_KEY_LEN,
                         max_mem = DEFAULT_MAX_MEM,
                         max_memfrac = DEFAULT_MAX_MEMFRAC,
                         max_time = DEFAULT_MAX_TIME,
                         cost = nil
                        )
      cost ||= calibrate(max_mem, max_memfrac, max_time)
      n, r, p = cost

      hash = crypto_scrypt(secret, salt, n, r, p, key_len)
      {"%x$%x$%x" % cost, salt, hash}.join('$')
    end

    def self.generate_salt(salt_size = DEFAULT_SALT_SIZE)
      SecureRandom.hex(salt_size / 2)
    end

    def self.crypto_scrypt(secret, salt, n, r, p, key_len)
      buffer = Slice(UInt8).new(key_len)

      secret_len = secret.bytesize
      salt_len = salt.bytesize / 2
      buffer_len = key_len

      salt_slice = Slice(UInt8).new(salt.bytesize / 2)

      1.step(to: salt.size, by: 2) do |i|
        salt_slice[(i - 1) / 2] = salt[i - 1 .. i].to_u8(16)
      end

      ret = LibScrypt.crypto_scrypt(secret, secret_len, salt_slice, salt_len, n, r, p, buffer, buffer_len)
      raise Error.new("crypto_scrypt failed") if ret != 0

      buffer.hexstring
    end

    def self.calibrate(max_mem = DEFAULT_MAX_MEM, max_memfrac = DEFAULT_MAX_MEMFRAC, max_time = DEFAULT_MAX_TIME)
      if LibScrypt.memtouse(max_mem, max_memfrac, out memlimit) != 0
        raise Error.new("can't determine memlimit")
      end

      if rc = LibScrypt.scryptenc_cpuperf(out opps) != 0
        raise Error.new("can't benchmark cpu (#{rc})")
      end

      opslimit = opps * max_time
      opslimit = 32768 if opslimit < 32768
      log_n = 1

      # we fix r
      r = 8_u32

      if opslimit < memlimit / 32
        # we fix p
        p = 1_u32

        # choose n based on the CPU limit
        max_n = opslimit / (r * 4)

        while log_n < 63
          break if 1_u64 << log_n > max_n / 2
          log_n += 1
        end
      else
        # choose n based on the memory limit
        max_n = memlimit / (r * 128)

        while log_n < 63
          break if 1_u64 << log_n > max_n / 2
          log_n += 1
        end

        # choose p based on the CPU limit
        max_rp = (opslimit / 4) / (1_u64 << log_n)
        max_rp = 0x3fffffff if max_rp > 0x3fffffff
        p = max_rp.to_u32 / r
      end

      n = 1_u64 << log_n

      {n, r, p}
    end
  end
end
