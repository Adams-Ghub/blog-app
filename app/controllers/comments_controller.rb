class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to "/users/#{@user.id}/posts"
    else
      render 'posts/show'
    end
  end
  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
   
    @comment.update_comment_counter
    if @comment.destroy
      @comment.update_comment_counter 
      redirect_to user_post_path(@user, @post), notice: 'Comment deleted successfully.'
    else
      redirect_to user_post_path(@user, @post), notice: 'Failed to delete comment.'
    end
  end
end
