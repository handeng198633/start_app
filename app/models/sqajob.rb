require 'open3'
class FileValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		unless value =~ /\A\/(nfs|projs00)/i
			record.errors[attribute] << (options[:message] || 'must from "/nfs" or "/projs00"!')
		end
		unless File.exist?(value) || File.symlink?(value)
			record.errors[attribute] << (options[:message] || "is not exist!")
		end
	end
end

class GbuildValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		build_value = value + "/bin/redhawk_main"
		unless File.exist?(build_value) || File.symlink?(build_value)
			record.errors[attribute] << (options[:message] || ": Goleden build is not a right redhawk directory!")
		end
	end
end

class NbuildValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		build_value = value + "/bin/redhawk"
		unless File.exist?(build_value) || File.symlink?(build_value)
			record.errors[attribute] << (options[:message] || ": New build is not a right redhawk directory!")
		end
	end
end

class EnvValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		if value
			value.split(';').each do |s|
				unless s.split('=').size == 2
					record.errors[attribute] << (options[:message] || "is not available!")
				end
			end
		end
	end
end

#class CasegroupValidator < ActiveModel::EachValidator
#	def validate_each(record, attribute, value)
#		unless 
#			record.errors[attribute] << (options[:message] || "can not be blank!")
#		end
#	end
#end

class Sqajob < ActiveRecord::Base
	has_many :sqajobstatuses, dependent: :destroy

	belongs_to :user
	default_scope -> { order('created_at DESC') }

	serialize :case_group, Array
	validates :jobname, presence: true, allow_blank: true
	validates :case_group, presence: true
	validates :gversion, presence: true 
	validates :nversion, presence: true
	validates :gbuild, presence: true, gbuild: true, allow_blank: true
	validates :nbuild, presence: true #nbuild: true
	validates :gsrfile, presence: true, file: true, allow_blank: true
	validates :genv, presence: true, env: true, allow_blank: true
	validates :nenv, presence: true, env: true, allow_blank: true
	validates :case_list_file, presence: true, file: true, allow_blank: true
	validates :slotthread, presence: true
	validates :user_id, presence: true
	validates :job_state, presence: true

	def self.from_users_followed_by(user)
		#insert SQL in database level
		followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		#where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
	end

	def updatejobstate(string)
		update_attribute(:job_state, string)
		update_attribute(:starttime, Time.zone.now)
	end

	def run!(sqajob)
		@sqajob = sqajob
	end

	def waitrun!(sqajob)
		@sqajob = sqajob
		#while to run sqajob script
		while not Sqajob.where(job_state: 'running').take.nil? do
			sleep 60
		end
		@sqajob.updatejobstate("running")
		@sqajob.save
		@sqajob.run!(@sqajob)
	end

	def stop!
		Open3.popen3('#{Rails.root}/public/stop_test_script.sh')
	end

end
