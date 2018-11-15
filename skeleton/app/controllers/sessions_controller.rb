class SessionsController < ApplicationController
  
  before_action :current_user, only: [:new, :destroy]
  
  def new
    redirect_to new_session_url
  end 
  
  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end 
  end 
  
  def create
    user = User.find_by(username: params[:user][:user_name])
    if user && BCrypt::Password.new(user.password_digest)
      .is_password?(params[:user][:password])
      login!(user)
      session[:session_token] = user.reset_session_token!
      user.save!
      redirect_to cats_url
    else 
      render json: 'Invalid credentials', status: 418
    end 
  end 
  
end 