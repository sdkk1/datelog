class User < ApplicationRecord
  has_many :datespots, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :favorites, dependent: :destroy
  has_many :favorite_datespots, through: :favorites, source: :datespot
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :from_notifications, class_name: "Notification", foreign_key: :from_user_id, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :browsing_histories, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  is_impressionable counter_cache: true

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  before_save :downcase_email

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  validates :introduction, length: { maximum: 255 }

  has_many_attached :avatars
  validate :avatar_type, :avatar_size, :avatar_length

  include JpPrefecture
  jp_prefecture :prefecture_code

  enum sex: { man: 0, woman: 1 }
  validates_presence_of :sex

  enum age: {
    age18: 18, age19: 19, age20: 20, age21: 21, age22: 22, age23: 23, age24: 24, age25: 25, age26: 26, age27: 27, age28: 28,
    age29: 29, age30: 30, age31: 31, age32: 32, age33: 33, age34: 34, age35: 35, age36: 36, age37: 37, age38: 38, age39: 39,
    age40: 40, age41: 41, age42: 42, age43: 43, age44: 44, age45: 45, age46: 46, age47: 47, age48: 48, age49: 49, age50: 50,
    age50over: 51
  }

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def followed_by?(other_user)
    followers.include?(other_user)
  end

  def favorite(datespot)
    Favorite.create!(user_id: id, datespot_id: datespot.id)
  end

  def unfavorite(datespot)
    Favorite.find_by(user_id: id, datespot_id: datespot.id).destroy
  end

  def favorite?(datespot)
    !Favorite.find_by(user_id: id, datespot_id: datespot.id).nil?
  end

  def list(datespot)
    List.create!(user_id: datespot.user_id, datespot_id: datespot.id, from_user_id: id)
  end

  def unlist(list)
    list.destroy
  end

  def list?(datespot)
    !List.find_by(datespot_id: datespot.id, from_user_id: id).nil?
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.id = 21
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def avatar_type
    avatars.each do |avatar|
      if !avatar.blob.content_type.in?(%('image/jpeg image/png'))
        avatar.purge
        errors.add(:avatars, 'はjpegまたはpng形式でアップロードしてください')
      end
    end
  end

  def avatar_size
    avatars.each do |avatar|
      if avatar.blob.byte_size > 5.megabytes
        avatar.purge
        errors.add(:avatars, "は1つのファイル5MB以内にしてください")
      end
    end
  end

  def avatar_length
    if avatars.length > 4
      avatars.purge
      errors.add(:avatars, "は4枚以内にしてください")
    end
  end
end
