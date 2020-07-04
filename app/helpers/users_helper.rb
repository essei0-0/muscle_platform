module UsersHelper

  def calc_growth(user, attr, perioud_units="month", perioud_number=1)
    if to_date = user.health_records.first&.measured_at

      case perioud_units
      when "day"
        from_date = to_date - perioud_number.day
      when "week"
        from_date = to_date - perioud_number.week
      when "month"
        from_date = to_date - perioud_number.month
      when "year"
        from_date = to_date - perioud_number.yaer
      end

      if from_record = user.health_records.find_by(measured_at: from_date.beginning_of_day...from_date.end_of_day)
        case attr
        when "height"
          from_attr = from_record.height
          to_attr = user.health_records.first.height
        when "weight"
          from_attr = from_record.weight
          to_attr = user.health_records.first.weight
        when "fat"
          from_attr = from_record.fat
          to_attr = user.health_records.first.fat
        when "muscle"
          from_attr = from_record.muscle
          to_attr = user.health_records.first.muscle
        end

        (to_attr - from_attr).round(1)
      else
        " ー "
      end
    else
      " ー "
    end
  end
end
