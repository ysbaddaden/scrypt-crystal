require "./engine"
require "./password"

module Scrypt
  DEFAULT_KEY_LEN = 32
  DEFAULT_SALT_SIZE = 8
  DEFAULT_MAX_MEM = 1024 * 1024
  DEFAULT_MAX_MEMFRAC = 0.5
  DEFAULT_MAX_TIME = 0.2

  class Error < Exception
  end
end
