class Hashtag < ApplicationRecord
  REGEX_HASHTAG = /#[A-zА-я0-9_]+/

  has_many :hashtag_questions
  has_many :questions, -> { distinct }, through: :hashtag_questions
  validates :name, presence: true
end
