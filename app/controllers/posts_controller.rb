class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @user = User.find(params[:user_id])
    @current_user = current_user
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.author_id = current_user.id

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      render :new
    end
  end
end
