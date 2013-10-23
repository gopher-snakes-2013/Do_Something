module SessionsHelper

def verify_login(user)
   if user && (user.password == params[:sign_in_user][:password])
    session[:user_id] = user.id
  else
    set_login_error  
  end
end

def verify_user_create(user)
  if user.save
    session[:user_id] = user.id
  else
    set_signup_error
  end
end

def logged_in?
  session[:user_id] ? true : false
end

def set_login_error
  flash[:log_in_error] = "Incorrect login. Please try again."  
end

def set_signup_error
  flash[:sign_up_error] = user.errors.messages
end

def flash_errors
  flash[:log_in_error]
  flash[:sign_up_error]
end



end
