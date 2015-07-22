class SqajobsController < ApplicationController
	before_action :signed_in_user, only: [:index, :create, :edit, :update, :destory]
	before_action :correct_user, only: [:create, :destroy]

	def index
		@sqajobs = Sqajob.paginate(page: params[:page])
	end

	def show
		@sqajob = Sqajob.find(params[:id])
	end

	def new
		@sqajob = Sqajob.new
	end

	def create
		@sqajob = current_user.sqajobs.build(sqajob_params)
		@sqajob.jobname = current_user.name.downcase + '_' + @sqajob.created_at
		if @sqajob.save
			flash[:success] = "Special QA job created"
			redirect_to @sqajob
		else
			@feed_items = []
			render 'new'
		end
	end

	def destroy
		@sqajob.destroy
		redirect_to root_url
	end

	private

		def sqajob_params
			params.require(:sqajob).permit(:gversion, {:case_group => []}, :nversion, :gbuild, :nbuild, :gsrfile, :genv, :nenv, :case_list_file, :slotthread)
		end
		def correct_user
			@sqajob = current_user.sqajobs.find_by(id: params[:id])
			redirect_to root_url if @sqajob.nil?
		end

end