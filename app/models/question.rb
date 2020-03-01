class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions
  after_commit :set_hashtags
  validates :text, presence: true, length: { maximum: 255 }

  def set_hashtags
    "#{text} #{answer}".downcase.scan(Hashtag::REGEX_HASHTAG).each do |substr|
      hashtags << Hashtag.find_or_create_by(name: substr)
    end
  end
end
