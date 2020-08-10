class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :datespot

  validates :user_id, presence: true
  validates :dish_id, presence: true
end
