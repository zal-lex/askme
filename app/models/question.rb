class Question < ApplicationRecord
  REGEX_HASHTAG = /#[a-zа-я0-9_]+/

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, -> { distinct }, through: :hashtag_questions
  before_save :set_hashtags
  validates :text, presence: true, length: { maximum: 255 }

  def set_hashtags
    answer ? (full_str = text + ' ' + answer) : full_str = text
    full_str.scan(REGEX_HASHTAG).each do |substr|
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
