class SessionsController < ApplicationController
  
  before_action :require_login, only: [:destroy]
  
  def new
    # redirect_to new_session_url
    render :new
  end 
  
  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end 
  end 
  
  def create
    user = User.find_by(user_name: params[:users][:user_name])
    if user && BCrypt::Password.new(user.password_digest).is_password?(params[:users][:password])
      login!(user)
      # session[:session_token] = user.reset_session_token!
      user.save!
      redirect_to cats_url
    else 
      render json: 'Invalid credentials', status: 418
    end 
  end 
  
  def require_login 
    unless current_user 
      redirect_to session_url
    end 
  end 
  
end 