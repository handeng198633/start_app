class User < ActiveRecord::Base
	#call back and make all mail address downcase before saved
	has_many :microposts, dependent: :destroy
	has_many :articles, dependent: :destroy

	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed

	has_many :reverse_relationships, foreign_key: "followed_id", 
									class_name: "Relationship", 
									dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum:15 }
	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@ansys.com/i
	validates :email, presence: true, 
					format: { with: VALID_EMAIL_REGEX }, 
					uniqueness: { case_sensitive: false }

#all about password secure is add to :has_secure_password	
	has_secure_password
	validates :password, length:{ maximum: 20 }

	def send_password_reset
		self.password_reset_token = User.encrypt(User.new_remember_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		Article.from_users_followed_by(self)
	end

	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)	
		end
end
