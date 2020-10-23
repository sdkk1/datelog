class BrowsingHistory < ApplicationRecord
  belongs_to :user
  belongs_to :datespot

  scope :sort_desc, -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :datespot_id, presence: true
end
