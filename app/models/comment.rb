class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :datespot, counter_cache: :comments_count

  scope :sort_desc, -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :datespot_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :rate, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 0.5 }, presence: true

  has_one_attached :picture
  validate :picture_type, :picture_size

  after_save :update_rate_avarage
  after_destroy :update_rate_avarage

  def update_rate_avarage
    datespot.update_rate_avarage
  end

  private

  def picture_type
    return unless picture.attached?
    if !picture.blob.content_type.in?(%('image/jpeg image/png'))
      picture.purge
      errors.add(:picture, 'はjpegまたはpng形式でアップロードしてください')
    end
  end

  def picture_size
    return unless picture.attached?
    if picture.blob.byte_size > 5.megabytes
      picture.purge
      errors.add(:picture, "は1つのファイル5MB以内にしてください")
    end
  end
end
