class SessionsController < ApplicationController

  def new

  end

  def create
    puts session_params.inspect
    if (user = User.authenticate_by(email: session_params[:email], password: session_params[:password]))
      login user
      redirect_to root_path, notice: "You have signed in successfully"
    else
      flash[:alert] = "Invalid user or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout current_user
    redirect_to root_url, notice: 'You have been logged out'
  end

  private

  def session_params
    params.permit(:email, :password, :authenticity_token)
  end
end