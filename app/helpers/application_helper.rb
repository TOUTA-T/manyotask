module ApplicationHelper
  def simple_time(time)
    time.strftime("%Y-%m-%d<br />%H:%M:%S")
  end

  # ログイン関連のヘルパー
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    current_user.present?
  end
end
