class AppsController < ApplicationController
    before_action :require_login
    
    def index
        @user = session[:id]
    end
    
    def show
    end

    def create
        @app = App.new(app_params)
    end
    
    def new
        @app = App.new
    end
end
