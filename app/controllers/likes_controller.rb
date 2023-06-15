class LikesController < ApplicationController
  def create
    like = Like.create(like_params)
    redirect_to user_post_url(current_user, like.post.id), flash: { notice: 'Post liked' }
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to user_post_url(current_user, like.post.id), flash: { warn: 'Post disliked' }
  end

  private

  def like_params
    params.require(:like).permit(:post_id).merge(author: current_user)
  end
end
