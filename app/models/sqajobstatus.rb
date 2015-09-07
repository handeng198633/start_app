class Sqajobstatus < ActiveRecord::Base
	belongs_to :sqajob
	validates :sqajob_id, presence: true
end
