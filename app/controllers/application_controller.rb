class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in?

  private

    def current_user
      return @current_user if defined?(@current_user)
      if session[:user_id]
        @current_user = User.find_by(id: session[:user_id])
      end
    end

    def signed_in?
      current_user.present?
    end

    def require_login
      unless signed_in?
        respond_to do |format|
          format.html { redirect_to new_session_path, alert: "Please sign in!" }
          format.json { render json: { error: "Unauthorized" }, status: :unauthorized }
        end
      end
    end
end
