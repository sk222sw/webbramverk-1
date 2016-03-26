class UsersController < ApplicationController

    def index
        
    end
    
    def new
       @user = User.new 
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:userid] = @user.id
            redirect_to apikey_path
        else
            render :action => "new"    
        end
    end
    
    ## log in actions
    
    def login
        u = User.find_by_email(params[:email])
        if u && u.authenticate(params[:password])
            session[:userid] = u.id
            redirect_to apikey_path
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

end
