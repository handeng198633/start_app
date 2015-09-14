class SqajobstatusesController < ApplicationController
	before_action :signed_in_user

	def create
		@sqajob = Sqajob.find(params[:sqajobstatus][:sqajob_id])
		@sqajobstatus = @sqajob.sqajobstatuses.build(sqajobstatus_params)
		if @sqajobstatus.save
			respond_to do |format|
				format.html { redirect_to @sqajob }
				format.js
			end
			@sqajob.updatejobstate("running")
			@sqajob.save
		end
	end

	def destroy
		@sqajob = Sqajob.find(params[:id])
		respond_to do |format|
			format.html { redirect_to @sqajob }
			format.js
		end
		@sqajob.updatejobstate("stopped")
		@sqajob.save
	end

	def sqajobstatus_params
		params.require(:sqajobstatus).permit(:sqajob_id)
	end
end