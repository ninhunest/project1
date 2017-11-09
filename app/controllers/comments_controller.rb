class CommentsController < ApplicationController
  before_action :load_micropost
  def create
    @comment = @micropost.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "create success"
      redirect_to request.referer
    else
      flash[:danger] =  "error"
      redirect_to request.referer
    end
  end
  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_micropost
    @micropost = Micropost.find_by id: params[:micropost_id]
  end
end
