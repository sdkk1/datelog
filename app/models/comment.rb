class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :datespot

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :datespot_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :rate, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 1 }, presence: true
end
