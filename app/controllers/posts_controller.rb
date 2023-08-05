class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    @posts = @user.posts.paginate(page: params[:page], per_page: 4)
  end

  def update_comment_counter
    self.comments_counter = comments.count
    save
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
    cookies[:post_id] = @post.id if @post.present?

    return unless @post.nil?

    redirect_to root_path, alert: 'Comment deleted successfully.'
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
    @post = Post.new(post_params.merge(author_id: @user.id))
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])

    authorize! :destroy, @post

    if @post.destroy!
      redirect_to user_path(@user),
                  alert: 'Post successfully deleted.'
    else
      redirect_to user_path(@user), alert: 'Failed to delete comment.'
    end
  end
end
