class ArticlesController < ApplicationController
	before_action :signed_in_user, only: [:create, :edit, :update, :destory]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def index
#		@articles = Article.order("created_at DESC")
	end

#	def show
#    	@article = Article.find(params[:id])
#    end

    def new
       @article = Article.new
  	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			flash[:success] = "article created"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def edit
		@article = current_user.articles.find_by(id: params[:id])
	end

	def update
	    @article = current_user.articles.find_by(id: params[:id])
	    if @article.update_attributes(article_params)
	       flash[:success] = "The article has been successfully updated."
	       redirect_to root_url
	    else
	       render 'edit'
	    end
  	end

	def destroy
		@article.destroy
		redirect_to root_url
	end

	private

		def article_params
			params.require(:article).permit(:title, :content)
		end

		def correct_user
			@article = current_user.articles.find_by(id: params[:id])
			redirect_to root_url if @article.nil?
		end
end