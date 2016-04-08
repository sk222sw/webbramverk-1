module SessionsHelper

    def log_in(user)
       session[:userid] = user.id 
    end
    
    def log_out
        session.delete(:userid)
        @current_user = nil
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:userid])
    end
    
    def logged_in?
        !current_user.nil?
    end
    
end
