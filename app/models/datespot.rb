class Datespot < ApplicationRecord
  belongs_to :user, counter_cache: :datespots_count
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :browsing_histories, dependent: :destroy
  acts_as_taggable_on :tags
  is_impressionable counter_cache: true

  scope :sort_desc, -> { order(updated_at: :desc) }

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true
  validates :range, presence: true
  validates :invitation, presence: true, length: { maximum: 50 }
  validates :plan, length: { maximum: 255 }

  has_many_attached :images
  validate :image_type, :image_size, :image_length

  include JpPrefecture
  jp_prefecture :prefecture_code
  validates :prefecture_code, presence: true

  enum range: {
    price_min: 0, price4000: 1, price6000: 2, price8000: 3, price10000: 4,
    price15000: 5, price20000: 6, price25000: 7, price30000: 8, price_max: 9
  }

  enum time_zone: {
    undecided: 0, midmorning: 1, afternoon: 2, night: 3, allday: 4
  }

  def feed_comment(datespot_id)
    Comment.where("datespot_id = ?", datespot_id)
  end

  def update_rate_avarage
    comments_average = comments.average(:rate)
    update(rate_average: comments_average)
  end

  private

  def image_type
    images.each do |image|
      if !image.blob.content_type.in?(%('image/jpeg image/png'))
        image.purge
        errors.add(:images, 'はjpegまたはpng形式でアップロードしてください')
      end
    end
  end

  def image_size
    images.each do |image|
      if image.blob.byte_size > 5.megabytes
        image.purge
        errors.add(:images, "は1つのファイル5MB以内にしてください")
      end
    end
  end

  def image_length
    if images.length > 6
      images.purge
      errors.add(:images, "は6枚以内にしてください")
    end
  end
end
