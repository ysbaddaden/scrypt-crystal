require "crypto/subtle"

module Scrypt
  class Password
    def self.create(password,
                    key_len = DEFAULT_KEY_LEN,
                    salt_size = DEFAULT_SALT_SIZE,
                    max_mem = DEFAULT_MAX_MEM,
                    max_memfrac = DEFAULT_MAX_MEMFRAC,
                    max_time = DEFAULT_MAX_TIME
                   )
      salt = Engine.generate_salt(salt_size.clamp(8, 32))
      hashed_password = Engine.hash_secret(password, salt,
                                           key_len: key_len.clamp(16, 512),
                                           max_mem: max_mem,
                                           max_memfrac: max_memfrac,
                                           max_time: max_time
                                          )
      new(hashed_password)
    end

    @parts : Array(String)

    def initialize(@raw_hash : String)
      @parts = @raw_hash.split("$")
    end

    def ==(password)
      key_len = digest.bytesize / 2
      hashed_password = Engine.hash_secret(password, salt, key_len: key_len, cost: cost)
      Crypto::Subtle.constant_time_compare(@raw_hash.to_slice, hashed_password.to_slice)
    end

    def cost
      {@parts[0].to_u64(16), @parts[1].to_u32(16), @parts[2].to_u32(16)}
    end

    def salt
      @parts[3]
    end

    def digest
      @parts[4]
    end

    def to_s(io)
      io << @raw_hash
    end

    def inspect(io)
      to_s(io)
    end
  end
end
