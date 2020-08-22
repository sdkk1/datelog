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
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :lists, dependent: :destroy

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

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 現在のユーザーがフォローされていたらtrueを返す
  def followed_by?(other_user)
    followers.include?(other_user)
  end

  # 投稿をお気に入り登録する
  def favorite(datespot)
    Favorite.create!(user_id: id, datespot_id: datespot.id)
  end

  # 投稿をお気に入り解除する
  def unfavorite(datespot)
    Favorite.find_by(user_id: id, datespot_id: datespot.id).destroy
  end

  # 現在のユーザーがお気に入り登録してたらtrueを返す
  def favorite?(datespot)
    !Favorite.find_by(user_id: id, datespot_id: datespot.id).nil?
  end

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
