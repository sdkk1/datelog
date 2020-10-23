class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true, length: { maximum: 255 }

  has_one_attached :picture
  validate :picture_type, :picture_size

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
