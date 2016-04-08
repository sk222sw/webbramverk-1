class UsersController < ApplicationController

    include SessionsHelper

    def index
        
    end
    
    def show
        @user = get_user
        @apps = @user.apps
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
            redirect_to u
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

end
