class ApikeysController < ApplicationController
    before_action :require_login

    def show
        @user = @current_app_user
    end
end
