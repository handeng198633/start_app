require 'open3'
module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def log_in(user)
		session[:user_id] = user.id	
	end

	def signed_in?
		!current_user.nil?
	end

	def logged_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user		
	end

	def current_user
#		remember_token = User.encrypt(cookies[:remember_token])
#		@current_user ||= User.find_by(remember_token: remember_token)
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def account_activation_mail(user)
		Open3.popen3('echo "Welcome to QA Web, please click the link to active your account: ' + 'http://sjorhqa128-1.ansys.com:3000/account_activations/' + user.activation_token + '/edit?email=' + user.email.gsub(/@/, '%40') + '" | mail -s "Account Activation" ' + user.email)
	end

	def current_user?(user)
		user == current_user	
	end

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url
			flash[:notice] = "Please sign in."
		end
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.fullpath
	end
end
