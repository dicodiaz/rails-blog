class CommentsController < ApplicationController
  def create
    comment = Comment.new(params.require(:comment).permit(:post_id, :text))
    comment.author = current_user
    return unless comment.save

    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @liked = Like.exists?(author: current_user, post: @post)
    render template: 'posts/show'
  end
end
