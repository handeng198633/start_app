class SqajobsController < ApplicationController
	before_action :signed_in_user, only: [:index, :create, :edit, :update, :destory]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def index
		@sqajob = Sqajob.paginate(page: params[:page])	
	end

	def show
		@sqajob = Sqajob.find(params[:id])
	end

	def new
		@sqajob = Sqajob.new
	end

	def create
		@sqajob = current_user.sqajobs.build(sqajob_params)
		if @sqajob.save
			flash[:success] = "Special QA job created"
			redirect_to @sqajob
		else
			@feed_items = []
			render 'new'
		end
	end

	def destroy
		@article.destroy
		redirect_to root_url
	end

	private

		def sqajob_params
			case_group_list = [:cpm, :dsr, :hc, :rhe_nx, :ssr, :dmp, 
								:tmsignalem, :accuracy, :ace, :apl, :aplmmx, :db, 
									:dynamic, :esd, :fao, :gds2db, :gds2df, :gds2rh,
										:gdsmmx, :hier, :low_power, :mmx, :nxsem, :power,
											:powerem, :psiclkjitter, :psiclktree, :psiwinder, :rhtech, :static,
												:substrate, :tclcmd, :tclquery, :vcd]
#			case_group_list.each do |g|
#				if not params[g].empty?
#					params[:sqajob][:case_group] << params[g]
#				end
#			end
			params.require(:sqajob).permit(:gversion, :case_group, :nversion, :gbuild, :nbuild, :gsrfile, :genv, :nenv, :case_list_file, :slotthread)#		end
		end
		def correct_user
			@sqajob = current_user.sqajobs.find_by(id: params[:id])
			redirect_to root_url if @sqajob.nil?
		end
end