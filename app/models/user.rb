require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  REGEX_EMAIL = /.+@.+\..+/.freeze
  REGEX_USERNAME = /\A\w+\z/.freeze
  REGEX_COLOR = /\A#\h{6}\z/.freeze

  attr_accessor :password

  has_many :questions, dependent: :destroy
  has_many :authored_questions, class_name: 'Question', foreign_key: 'author_id', dependent: :nullify
  before_save :encrypt_password
  before_validation :normalized_case
  validates :email, :username, presence: true, uniqueness: true
  validates :email, format: { with: REGEX_EMAIL }
  validates :username, length: { maximum: 40 }, format: { with: REGEX_USERNAME }
  validates :password, presence: true, on: :create, confirmation: true
  validates :color_code, format: { with: REGEX_COLOR }, allow_blank: true
  scope :sorted, -> { order(id: :desc) }

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack1('H*')
  end

  def encrypt_password
    return unless password.present?
    self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
    self.password_hash = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(password, password_salt, ITERATIONS, DIGEST.length, DIGEST)
    )
  end

  def normalized_case
    username&.downcase!
    email&.downcase!
  end
end
