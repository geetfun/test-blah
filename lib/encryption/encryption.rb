require 'securerandom'
require 'bcrypt'

# Borrowed from http://github.com/binarylogic/authlogic/ Authlogic::Random
module Encryption
  module Encryption
    include BCrypt
    include SecureRandom
  
    # Handles generating random strings. If SecureRandom is installed it will default to this and use it instead. SecureRandom comes with ActiveSupport.
    # So if you are using this in a rails app you should have this library.
    extend self

    def hex_token
      SecureRandom.hex(64)
    end

    def friendly_token
      # use base64url as defined by RFC4648
      SecureRandom.base64(15).tr('+/=', '-_ ').strip.delete("\n")
    end
  end
end