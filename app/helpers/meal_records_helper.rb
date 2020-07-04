module MealRecordsHelper
  require "active_support"
  require "active_support/number_helper"

  def cut_zero(num)
    ActiveSupport::NumberHelper.number_to_rounded(num, strip_insignificant_zeros: true)
  end

end
