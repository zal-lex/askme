class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions
  after_commit :set_hashtags, on: %i[create update]
  validates :text, presence: true, length: { maximum: 255 }

  def set_hashtags
    hashtags.clear
    "#{text} #{answer}".downcase.scan(Hashtag::REGEX_HASHTAG).uniq.each do |tag|
      hashtags << Hashtag.find_or_create_by(name: tag)
    end
  end
end
