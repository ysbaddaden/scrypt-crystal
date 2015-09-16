module Scrypt
  class Password
    def self.create(password,
                    key_len = DEFAULT_KEY_LEN,
                    salt_size = DEFAULT_SALT_SIZE,
                    max_mem = DEFAULT_MAX_MEM,
                    max_memfrac = DEFAULT_MAX_MEMFRAC,
                    max_time = DEFAULT_MAX_TIME
                   )
      key_len = 16 if key_len < 16
      key_len = 512 if key_len > 512

      salt_size = 8 if salt_size < 8
      salt_size = 32 if salt_size > 32

      salt = Engine.generate_salt(salt_size)
      hashed_password = Engine.hash_secret(password, salt,
                                           key_len: key_len,
                                           max_mem: max_mem,
                                           max_memfrac: max_memfrac,
                                           max_time: max_time
                                          )
      new(hashed_password)
    end

    def initialize(@raw_hash)
      @parts = @raw_hash.split("$")
    end

    def ==(password)
      key_len = digest.bytesize / 2
      hashed_password = Engine.hash_secret(password, salt, key_len: key_len, cost: cost)
      @raw_hash == hashed_password
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
