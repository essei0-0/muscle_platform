class HealthRecord < ApplicationRecord
  belongs_to :user
  before_save :calc_muscle, if: :fat
  before_save :calc_bmi, :calc_bmr, if: :height
  default_scope -> { order(measured_at: :desc) }
  validates :user_id, presence: true
  validates :weight, presence: true
  validates :measured_at, presence: true
  validate :check_once_a_day


  #筋肉率
  def calc_muscle
    lbm = weight - (weight * (fat / 100))
    self.muscle = (((lbm / 2) / weight) * 100).round(1)
  end

  #ハリスベネディクト方程式で基礎代謝を求める
  #男性と女性で違う方程式になる
  def calc_bmr
    if age = user.convert_birthday_into_age
      self.bmr = (13.397 * weight + 4.799 * height - 5.677 * age + 88.362).round
    end
  end

  #BMI ＝ (体重kg) ÷ (身長m) ×　(身長m)
  def calc_bmi
    self.bmi = (weight / ((height/100) ** 2)).round(1)
  end

  private
  #体重の記録を一日一回までに制限するバリデーション
  def check_once_a_day
    HealthRecord.where(user_id: user_id).each do |health_record|
      if measured_at&.strftime("%Y/%m/%d") == health_record.measured_at.strftime("%Y/%m/%d")
        errors.add(:measured_at, "はすでに存在します")
        break
      end
    end
  end

end
