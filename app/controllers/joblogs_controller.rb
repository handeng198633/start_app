class JoblogsController < ApplicationController
	before_action :signed_in_user, only: :show

	def show
		@sqajob = Sqajob.find(params[:id])
		@joblog = Joblog.new
		@joblog.jobname = @sqajob.jobname
	end
end