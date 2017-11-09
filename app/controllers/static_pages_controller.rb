class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.sort_by_created_at.paginate page: params[:page], per_page: 5
    end
  end
end
