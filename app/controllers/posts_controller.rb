class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @like = Like.find_by(author: current_user, post: @post) || Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to user_post_url(current_user, @post.id), flash: { success: 'Post saved successfully' }
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence.prepend('Error(s): ')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text).merge(author: current_user)
  end
end
