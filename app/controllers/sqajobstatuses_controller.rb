class SqajobstatusesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :update]

	def create
		@sqajob = Sqajob.find(params[:sqajobstatus][:sqajob_id])
		@sqajobstatus = @sqajob.sqajobstatuses.build(sqajobstatus_params)
		if @sqajobstatus.save
			respond_to do |format|
				format.html { redirect_to @sqajob }
				format.js
			end
			if Sqajob.where(job_state: 'running').take.nil?
				@sqajob.updatejobstate("running")
				@sqajob.save
				@sqajob.run!(@sqajob)
			else
				@sqajob.updatejobstate("waiting")
				@sqajob.save
			end
		end
	end

	def destroy
		@sqajobstatus = Sqajobstatus.find_by(id: params[:id])
		@sqajob = Sqajob.find(params[:sqajobstatus][:sqajob_id])
		@sqajobstatus.destroy
		respond_to do |format|
			format.html { redirect_to @sqajob }
			format.js
		end
		@sqajob.updatejobstate("stopped")
		@sqajob.save
	end

	def update
		@sqajob = Sqajob.find(params[:sqajobstatus][:sqajob_id])
		respond_to do |format|
			format.html { redirect_to @sqajob }
			format.js
		end
	end

	def sqajobstatus_params
		params.require(:sqajobstatus).permit(:sqajob_id)
	end

end