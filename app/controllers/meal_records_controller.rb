class MealRecordsController < ApplicationController
  def new
    m = current_user.meal_records
    @meal_records = m.take(current_user.meal_records.count)

    if m.first&.base_gram && m.first&.ate_gram
      mul =  m.first&.ate_gram / m.first&.base_gram
      protein = (m.first&.protein / mul).round(1)
      fat = (m.first&.fat / mul).round(1)
      carbo = (m.first&.carbo / mul).round(1)
    end

    @meal_record = m.build(base_gram: m.first&.base_gram, protein: protein, fat: fat, carbo: carbo, food: m.first&.food, ate_gram: m.first&.ate_gram, ate_at: DateTime.now)
  end

  def edit
  end

  def create
    m = current_user.meal_records
    @meal_records = m.take(current_user.meal_records.count)
    @meal_record = m.build(meal_record_params)

    if @meal_record.save
      flash[:success] = "記録しました！"
      redirect_to meal_records_url
    else
      flash.now[:danger] = "失敗しました！"
      render 'new'
    end
  end

  def destroy
  end

  private

  def meal_record_params
    params.require(:meal_record).permit(:base_gram, :protein, :fat, :carbo, :food, :ate_gram, :calorie, :ate_at, :note, :picture)
  end

end
