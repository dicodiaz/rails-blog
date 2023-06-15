class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to user_post_url(current_user, @comment.post_id), flash: { success: 'Comment saved successfully' }
    else
      p flash.now[:error] = @comment.errors.full_messages.to_sentence.prepend('Error(s): ')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    @post = Post.find(params[:post_id])
    params.require(:comment).permit(:text).merge(post: @post, author: current_user)
  end
end
