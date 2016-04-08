module UsersHelper

    def log_in(user)
        session[:userid] = user.id
    end

end
