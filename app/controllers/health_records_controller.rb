class HealthRecordsController < ApplicationController

  def create
    h = current_user.health_records
    @health_records = h.take(current_user.health_records.count)
    @health_record = h.build(health_record_params)
    
    if @health_record.save
      flash[:success] = "記録しました！"
      redirect_to health_records_url
    else
      flash[:danger] = "失敗しました！"
      render 'users/health_records'
    end
  end

  def destroy
  end

  private

  def health_record_params
    params.require(:health_record).permit(:height, :weight, :fat, :measured_at, :muscle, :bmr, :bmi)
  end

end
