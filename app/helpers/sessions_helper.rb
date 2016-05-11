module SessionsHelper

    def log_in(user)
       session[:userid] = user.id 
    end
    
    def log_out
        session.delete(:userid)
        @current_app_user = nil
    end
    
    def current_app_user
        @current_app_user ||= User.find_by(id: session[:userid])
    end
    
    def logged_in?
        !current_app_user.nil?
    end
    
end
