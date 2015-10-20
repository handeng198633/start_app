class SqajobsController < ApplicationController
	before_action :signed_in_user, only: [:index, :create, :update, :new, :show]
	before_action :admin_user, only: :destroy

	def index
		@sqajobs = Sqajob.paginate(page: params[:page],:per_page => 7 )
	end

	def show
		@sqajob = Sqajob.find(params[:id])
	end

	def new
		@sqajob = Sqajob.new
	end

	def update
		
	end

	def create
		@sqajob = current_user.sqajobs.build(sqajob_params)
		jobname = 'SQJ' + '_' + current_user.name + '_' + Time.now.to_s(:number) 
		@sqajob.jobname = jobname
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
		redirect_to sqajobs_path
	end


	private

		def sqajob_params
			params.require(:sqajob).permit(:jobname, :gversion, {:case_group => []}, :nversion, :gbuild, :nbuild, :gsrfile, :genv, :nenv, :case_list_file, :slotthread)
		end

		def correct_user
			@sqajob = current_user.sqajobs.find_by(id: params[:id])
			redirect_to root_url if @sqajob.nil?
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end


end