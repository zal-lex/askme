class Hashtag < ApplicationRecord

  has_many :hashtag_questions
  has_many :questions, -> { distinct }, through: :hashtag_questions
  validates :name, presence: true
end
