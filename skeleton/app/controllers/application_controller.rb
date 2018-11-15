class ApplicationController < ActionController::Base
  
  helper_method :current_user
  
  def current_user 
    user = User.find_by(session_token: params[:user][:session_token])
    return user if user 
    return nil 
  end 
  
  def login!(user)
    session[:session_token] = user.reset_session_token!
  end 
  
  
end
