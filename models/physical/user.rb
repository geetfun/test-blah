class User < Sequel::Model
  include Encryption
  BCRYPT_COST = 10
  
  # one_to_many :profiles
  
  attr_accessor :password
  
  def before_save
    self.password_salt = generate_or_get_salt
    self.crypted_password = encrypt_password
  end
  
  def encrypt_password
    BCrypt::Password.create(password, :cost => BCRYPT_COST, :salt => password_salt)
  end
  
  def generate_or_get_salt
    password_salt || Encryption.friendly_token
  end
  
  def validate
    # empty attributes
    validate_email
    errors[:password] << "can't be empty" if password.empty?
  end
  
  def validate_email
    return errors[:email] << "can't be empty" if email.empty?
    return errors[:email] << "format is not correct" unless ( email =~ User.email_format )
  end
  
  def self.email_format
    return @email_regex if @email_regex
    email_name_regex  = '[A-Z0-9_\.%\+\-]+'
    domain_head_regex = '(?:[A-Z0-9\-]+\.)+'
    domain_tld_regex  = '(?:[A-Z]{2,4}|museum|travel)'
    @email_regex = /\A#{email_name_regex}@#{domain_head_regex}#{domain_tld_regex}\z/i
  end
  
end