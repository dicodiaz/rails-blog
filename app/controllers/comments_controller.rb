class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:create]

  def index
    @post = Post.find_by(id: params[:post_id])
    return render404('Post') unless @post

    @comments = @post.comments
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      format.html do
        if @comment.save
          redirect_to user_post_url(current_user, @comment.post_id), flash: { success: 'Comment saved successfully' }
        else
          p flash.now[:error] = @comment.errors.full_messages.to_sentence.prepend('Error(s): ')
          render :new, status: :unprocessable_entity
        end
      end
      format.json do
        if @comment.save
          render json: @comment.to_json, status: :created
        else
          render json: { error: @comment.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    comment = Comment.destroy(params[:id])
    redirect_to user_post_path(comment.post.author, comment.post)
  end

  private

  def comment_params
    @post = Post.find(params[:post_id])
    params.require(:comment).permit(:text).merge(post: @post, author: current_user)
  end
end
