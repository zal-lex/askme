class Question < ApplicationRecord

  belongs_to :user
  validates :text, :user, presence: true
  validates_length_of :text, maximum: 255, message: "less than 255 if you don't mind"

end
