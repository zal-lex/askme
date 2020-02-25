class Hashtag < ApplicationRecord
  REGEX_HASHTAG = /\A#[a-zа-я0-9_]+\z/

  has_many :hashtag_questions
  has_many :questions, through: :hashtag_questions
  validates :name, format: { with: REGEX_HASHTAG }, presence: true
end
