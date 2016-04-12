class UsersController < ApplicationController
    include SessionsHelper
    before_action :require_login, only: [:show]
    before_action :get_user, only: [:show]
    before_action :correct_user, only: [:show]
    before_action :logged_in_user, only: [:show]


    def index
        
    end
    
    def show
        if @user.admin?
            @users = User.all
            @apps = App.all
        else
            @user = get_user
            @apps = @user.apps
        end
    end
    
    def new
       @user = User.new 
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            session[:userid] = @user.id
            redirect_to @user
        else
            render :action => "new"
        end
    end
    
    ## log in actions
    
    def login
        u = User.find_by_email(params[:email])
        if u && u.authenticate(params[:password])
            log_in u
            session[:userid] = u.id
            redirect_back_or u
        else
            flash[:notice] = "Failed to login"
            redirect_to root_path
        end
    end

    def logout
        session.delete(:userid)
        redirect_to root_path, :notice => "logged out"
    end

    private
    
    def user_params
       params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def get_user
        @user = User.find(params[:id])
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
  def current_user?(user)
    user == current_user
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to current_user unless current_user?(@user)
  end    
    
end
