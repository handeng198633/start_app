class Article < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true, length: { maximum:140 }
	validates :content, presence: true, length: { maximum:1400 }
	validates :user_id, presence: true

	def self.from_users_followed_by(user)
		#insert SQL in database level
		followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		#where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
	end
end