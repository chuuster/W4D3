class UsersController < ApplicationController 
    
  before_action :require_login, only: [:new] #things go here 
  
  def new 
    render :new 
  end 
  
  def require_login
    if current_user
      redirect_to cats_url 
    end 
  end 
  
  def create 
    user = User.new(user_params)
    if user.save!
      login!(user)
      redirect_to cats_url
    else 
      render json: 'Invalid credentials', status: 418
    end 
  end 
  
  
  private 
  def user_params
    params.require(:users).permit(:user_name, :password)
  end 
  
end 