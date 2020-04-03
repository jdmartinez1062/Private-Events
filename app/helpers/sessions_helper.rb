module SessionsHelper

    def log_in(user)
        session[:user_id]=user.id
    end

    def current_user
        return unless  (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)

    end
   
    def current_user?(user)
        user == current_user
    end
    
    def logged_in?
        !current_user.nil?
    end

    def current_user=(user)
        @current_user = user
    end

    def log_out(user)

        sessions.delete(:user_id)
        @current_user = nil

    end
end
