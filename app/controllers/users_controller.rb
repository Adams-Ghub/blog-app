class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    cookies[:user_id] = @user.id
  end
  # load_and_authorize_resource
end
