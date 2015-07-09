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
#		if attribute[0].nil?
#			record.errors[attribute] << (options[:message] || "can not be blank!")
#		end
#	end
#end

class Sqajob < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }

	validates :gversion, presence: true 
	validates :nversion, presence: true
	validates :gbuild, presence: true, gbuild: true, allow_blank: true
	validates :nbuild, presence: true, nbuild: true
	validates :gsrfile, presence: true, file: true, allow_blank: true
	validates :genv, presence: true, env: true, allow_blank: true
	validates :nenv, presence: true, env: true, allow_blank: true
	validates :case_list_file, presence: true, file: true, allow_blank: true
	validates :slotthread, presence: true
	validates :user_id, presence: true

end
