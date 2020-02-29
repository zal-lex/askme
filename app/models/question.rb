class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, -> { distinct }, through: :hashtag_questions
  before_save :set_hashtags
  validates :text, presence: true, length: { maximum: 255 }

  def set_hashtags
    answer ? (full_str = text + ' ' + answer) : full_str = text
    full_str.scan(Hashtag::REGEX_HASHTAG).each do |substr|
      next if substr.length > 25
      tag = substr.downcase
      hashtag = Hashtag.find_by(name: tag)
      if hashtag
        hashtag.touch
      else
        hashtag = Hashtag.new(name: tag)
        hashtag.save!
      end
      hashtags << hashtag
    end
  end
end
