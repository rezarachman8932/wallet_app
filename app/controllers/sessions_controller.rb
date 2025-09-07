class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create, :destroy ]

  def new
    # login form
  end

  def create
    user = User.find_by(email: params[:email]&.downcase)

    if user&.authenticate(params[:password])
      # Reset and set session to prevent fixation attacks
      reset_session
      session[:user_id] = user.id

      # Optionally set a short expiration in session (seconds)
      session[:expires_at] = 1.hour.from_now

      redirect_to root_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Invalid email or password!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: "Logged out!"
  end
end
