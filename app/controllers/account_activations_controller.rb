class AccountActivationsController < ApplicationController
	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? 
			user.activate
			log_in user
			flash[:success] = "Account Activated"
		else
			flash[:danger] = "Sorry, Invalid activation link"
		end
		redirect_to root_url
	end
end
