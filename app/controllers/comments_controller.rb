class CommentsController < ApplicationController
  before_action :load_micropost
  def create
    @comment = @micropost.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = t "create_success"
          redirect_to :back
        end
        format.js
      end
    else
      flash[:danger] = t "error"
      redirect_to :back
    end
  end
  def destroy
    @comment = current_user.comments.find_by id: params[:id]
    @comment.destroy
    flash[:success] = "comment deleted"
    redirect_to request.referrer || root_url
  end
  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_micropost
    @micropost = Micropost.find_by id: params[:micropost_id]
  end
end
