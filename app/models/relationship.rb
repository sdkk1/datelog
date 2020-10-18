class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User", counter_cache: :followed_count

  scope :sort_desc, -> { order(created_at: :desc) }

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
