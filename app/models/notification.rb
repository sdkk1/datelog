class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :datespot, optional: true

  validates :user_id, presence: true
  validates :variety, presence: true
  validates :from_user_id, presence: true
end
