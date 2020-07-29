class Datespot < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :area, presence: true
  validates :price, presence: true
  validates :keyword, presence: true, length: { maximum: 50 }
  validates :point, length: { maximum: 255 }
  validates :caution, length: { maximum: 255 }
end
