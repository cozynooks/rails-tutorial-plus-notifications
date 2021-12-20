class NotificationsController < ApplicationController
  def index
    results = current_user.notifications.order(created_at: :desc)
    num = 0 # 通知列の数
    user_num = 0
    additional_message = ""
    @notifications = []
    results.each do |result|
      if result.subject_type == 'Relationship'
        if @prev_created_at.present?
          if @prev_created_at <= result.created_at + 5.minutes
            user_num += 1
            additional_message = "他" + user_num.to_s + "人"
          else
            num += 1
            user_num = 0
            additional_message = ""
          end
        end
        @prev_created_at = result.created_at
        @notifications[num] = {
          subject_type: result.subject_type,
          message: result.subject.follower.name + additional_message + "にフォローされました。",
        }
      else
        @notifications << {
          subject_type: result.subject_type,
          message: "初回ログインありがとうございます。"
        }
      end
    end
  end

end