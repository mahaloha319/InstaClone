class Picture < ApplicationRecord
  validates :comment, presence: true
  validates :comment, length:{in: 1..300}
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  mount_uploader :image, ImageUploader
end
