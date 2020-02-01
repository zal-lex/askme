require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  
  attr_accessor :password

  has_many :questions
  before_validation :normalized_case  
  before_save :encrypt_password
  validates :email, :username, presence: true, uniqueness: true
  validates :email, format: { with: /.+@.+\..+/ }
  validates :username, length: { maximum: 40 }, format: { with: /\A\w+\z/ }
  validates :password, presence: true, on: :create, confirmation: true

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def normalized_case
    self.username.downcase!
    self.email.downcase!
  end
end
