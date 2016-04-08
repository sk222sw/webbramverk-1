class AppsController < ApplicationController
    before_action :require_login
    
    def index
        @user = session[:id]
    end
    
    def show
    end

    def create
        @app = current_user.apps.build(apps_params)
        if @app.save
            flash[:notice] = "App created - woop woop!"
            redirect_to @current_user
        else
            flash[:notice] = "Woops, something wen't wrong :/"
        end
    end
    
    def new
        @app = App.new
    end
    
    private
    
    def apps_params
        params.require(:app).permit(:name)
    end
end
