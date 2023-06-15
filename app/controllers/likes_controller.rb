class LikesController < ApplicationController
  def create
    permitted_params = params.require(:like).permit(:post_id, :like)
    post_id = permitted_params[:post_id]
    if permitted_params[:like] == 'true'
      Like.create(author: current_user, post_id:)
    else
      Like.delete_by(author: current_user, post_id:)
    end

    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @liked = Like.exists?(author: current_user, post: @post)
    render template: 'posts/show'
  end
end
