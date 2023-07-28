class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new(user: @user, post: @post)
    if @like.save
      @post.update(likes_counter: @post.likes_counter + 1)
      redirect_to user_post_path(@post.author_id, @post)
    else
      redirect_to user_post_path(@post.author_id, @post), alert: 'Failed to like the post.'
    end
  end
end
