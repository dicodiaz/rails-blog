class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    return render_404('User') unless @user

    @posts = @user.posts.includes(:comments).sort

    respond_to do |format|
      format.html do
        @pagination = @posts.size > 2
        return unless @pagination

        @page = params[:page]&.to_i || 1
        @total_pages = (@posts.size + 1) / 2
        @posts = @posts.each_slice(2).to_a[@page - 1]
      end

      format.json { render json: @posts }
    end
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
