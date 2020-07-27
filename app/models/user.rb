class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  validates :introduction, length: { maximum: 255 }

  enum sex: { man: 1, woman: 2 }

  mount_uploader :picture, PictureUploader
  validate :picture_size

  private

  def downcase_email
    self.email = email.downcase
  end

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "5MB以内にしてください")
    end
  end
end
