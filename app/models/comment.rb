class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :datespot

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :datespot_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
