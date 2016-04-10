class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:userid])
  end
  
  def redirect_back_or(default)
    redirect_to(:session[:forwarding_url] || url)
    session.delete(:forwarding_url)
  end
  
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end  
  
  def log_in(user)
    session[:userid] = user.id
  end
  
  def logged_in?
    !current_user.nil?
  end
  
end
