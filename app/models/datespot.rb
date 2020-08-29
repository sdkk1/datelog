class Datespot < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :lists, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :place, presence: true
  validates :range, presence: true
  validates :keyword, presence: true, length: { maximum: 50 }
  validates :point, length: { maximum: 255 }
  validates :caution, length: { maximum: 255 }

  mount_uploader :picture, PictureUploader
  validate :picture_size

  enum place: {
    Ginza: 0, Yurakucho: 1, Shinbashi: 2, Hamamatsucho: 3, Tamachi: 4, Shinjuku: 5,
    Yoyogi: 6, Okubo: 7, Shibuya: 8, Omotesando: 9, Aoyama: 10, Harajuku: 11,
    Akasaka: 12, Roppongi: 13, Azabu: 14, Marunouchi: 15, Nihonbashi: 16, Kanda: 17,
    Ningyocho: 18, Ikebukuro: 19, Jiyugaoka: 20, Sangenjaya: 21, Futakotamagawa: 22, Shinagawa: 23,
    Gotanda: 24, Osaki: 25, Odaiba: 26, Toyosu: 27, ebisu: 28, Hiroo: 29,
    Shirogane: 30, Daikanyama: 31, Nakameguro: 32, Meguro: 33, Iidabashi: 34, Yotsuya: 35,
    Kagurazaka: 36, Ueno: 37, Asakusa: 38, Nakano: 39, Kichijoji: 40, Tachikawa: 41, Others: 42
  }

  enum range: {
    price_min: 0, price4000: 1, price6000: 2, price8000: 3, price10000: 4, price15000: 5,
    price20000: 6, price25000: 7, price30000: 8, price40000: 9, price50000: 10, price_max: 11
  }

  def feed_comment(datespot_id)
    Comment.where("datespot_id = ?", datespot_id)
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "5MB以内にしてください")
    end
  end
end
