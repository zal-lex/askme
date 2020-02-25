class Question < ApplicationRecord
  REGEX_HASHTAG = /\A#[a-zа-я0-9_]+\z/

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtag_questions
  has_many :hashtags, through: :hashtag_questions
  before_save :set_hashtags
  validates :text, presence: true, length: { maximum: 255 }

  def set_hashtags
    text.scan(REGEX_HASHTAG).each do |substr|
      next if substr.length > 25
      hashtag = Hashtag.find_by(name: substr)
      if hashtag
        hashtag.touch
      else
        hashtag = Hashtag.new(name: substr)
        hashtag.save!
      end
      hashtags << hashtag
    end
  end
end
