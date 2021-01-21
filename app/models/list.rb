class List < ApplicationRecord
  belongs_to :user
  belongs_to :datespot, counter_cache: :lists_count

  scope :sort_desc, -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :datespot_id, presence: true
  validates :from_user_id, presence: true
end
