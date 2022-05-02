class Micropost < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :reposts, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  validates :content_or_picture, presence: true
  validate  :picture_size

  private

  def content_or_picture
      content.presence or picture.presence
  end

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
