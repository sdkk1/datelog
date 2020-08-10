class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :datespot

  validates :user_id, presence: true
  validates :datespot_id, presence: true
end
