class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
#			sign_in user
			if user.activated?
				log_in user
				params[:session][:remember_me] == '1' ? remember(user) : forget(user)
				redirect_to root_path
			else
				flash[:warning] = "Account not activated.please check your activation link"
				redirect_to root_url
			end
		else
			flash.now[:error] = 'Invalid Email/Password Combination'
			render 'new'
		end
	end
	
	def destroy
#		sign_out
		log_out if logged_in?
		redirect_to root_path
	end
end
