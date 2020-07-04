class MealRecord < ApplicationRecord
  belongs_to :user
  before_save :calc_to_create
  default_scope -> { order(ate_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :note, length: { maximum: 140 }
  validates :protein, presence: true
  validates :fat, presence: true
  validates :carbo, presence: true
  validates :ate_at, presence: true
  validate :check_gram

  def check_gram
    if !!base_gram ^ !!ate_gram
      errors.add(:base, "基準と摂取量はセットで入力してください")
    end
  end

  def calc_to_create
    base_calorie = (protein + carbo) * 4 + fat * 9
    if base_gram && ate_gram
      mul = ate_gram / base_gram
      self.protein = protein * mul
      self.fat = fat * mul
      self.carbo = carbo * mul
      self.calorie = base_calorie * mul
    else
      self.calorie = base_calorie
    end
  end

end
