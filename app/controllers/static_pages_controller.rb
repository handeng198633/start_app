class StaticPagesController < ApplicationController

  def home
  	if signed_in?
    @sqajob = current_user.sqajobs.build
    @article = current_user.articles.build
		@feed_items = current_user.feed.paginate(page: params[:page], :per_page => 3)
    @feed_jobs =current_user.feedsqajob.paginate(page: params[:page], :per_page => 3)
	end
  end

  def help
  end

  def about
  end

  def contact
  end
end
