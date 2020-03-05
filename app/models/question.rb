class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions
  before_save :reset_hashtags
  after_commit :set_hashtags, on: %i[create update]
  validates :text, presence: true, length: { maximum: 255 }

  def reset_hashtags
    hashtag_questions.delete_all
  end

  def set_hashtags
    uniq_tags = []
    "#{text} #{answer}".downcase.scan(Hashtag::REGEX_HASHTAG).each do |substr|
      unless uniq_tags.include?(substr)
        uniq_tags << substr
        hashtags << Hashtag.find_or_create_by(name: substr)
      end
    end
  end
end
