class Comment < ApplicationRecord
  belongs_to :datespot
  validates :user_id, presence: true
  validates :datespot_id, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
