class Api::CommentsController<ApplicationController
    def index
        @comments = Comment.all
        render json: @comments
    end
    def create
        @post = Post.find(params[:post_id])
        @user = User.find(params[:user_id])
        @comment = Comment.new(comment_params)
        @comment.post = @post
        @comment.user = current_user
        if @comment.save
         render json: @comment, status: :created
        else
          render json: {errors: @comments.errors.full_message}, status: comments_not_created
        end
    end

    def comment_params
        params.require(:comment).permit(:text)
    end
end