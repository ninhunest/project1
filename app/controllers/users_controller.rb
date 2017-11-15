class UsersController < ApplicationController
  before_action :logged_in_user, only: :index

  before_action :load_user, only: :show

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.sort_by_created_at.paginate page: params[:page],
    per_page: 5
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:warning] =  t "can_not_find_user"
    redirect_to root_path
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
