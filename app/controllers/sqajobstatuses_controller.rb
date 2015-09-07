class SqajobstatusesController < ApplicationController
	before_action :signed_in_user

	def create
		@sqajob = Sqajob.find(params[:sqajobstatus][:sqajob_id])
		respond_to do |format|
			format.html { redirect_to @sqajob }
			format.js
		end
		@sqajob.updatejobstate("running")
		@sqajob.save
	end
end