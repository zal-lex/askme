class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :reverse_users, -> { order(id: :desc) }
end
