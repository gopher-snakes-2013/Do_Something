module SessionHelper
  def logged_in?
    session[:user_id] ? true : false
  end

  def active_user
    @cached_active_user ||= User.find(session[:user_id]) if logged_in?
  end

  def make_active(user)
    session[:user_id] = user.id
  end

  def logout
    session.clear
  end
end
