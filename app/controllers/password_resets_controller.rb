class PasswordResetsController < ApplicationController
  def create
  	  user = User.find_by_email(params[:email])
  	  user.send_password_reset if user
      redirect_to root_url
      flash[:success] = "Email sent with password reset instructions."
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 1.hours.ago
    	redirect_to new_password_reset_path
    	flash.now[:error] = "Password reset has expired."
  	elsif @user.update_attributes(params[:user])
    	redirect_to root_url
    	flash[:success] = "Password has been reset!"
  	else
    	render :edit
  	end
  end
end
