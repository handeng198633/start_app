class User < ActiveRecord::Base
	#call back and make all mail address downcase before saved
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum:15 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
					format: { with: VALID_EMAIL_REGEX }, 
					uniqueness: { case_sensitive: false }

#all about password secure is add to :has_secure_password	
	has_secure_password
	validates :password, length:{ minimum: 6, maximum: 20 }
end
