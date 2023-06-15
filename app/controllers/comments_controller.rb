class CommentsController < ApplicationController
  def create
    comment = Comment.new(params.require(:comment).permit(:post_id, :text))
    comment.author = current_user
    return unless comment.save

    @post = Post.find(params[:post_id])
    render template: 'posts/show'
  end
end
