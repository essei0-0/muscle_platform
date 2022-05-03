class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      # 通知を取得したらチェック済みに更新する
      notification.update_attributes(checked: true)
    end
  end
end