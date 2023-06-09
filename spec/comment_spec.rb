require 'rails_helper'

RSpec.describe Comment, type: :model do
  context '::update_comments_counter' do
    it 'should update the comments_counter for a given post' do
      post = Post.new(author: User.new, title: 'Title')
      Comment.create(author: User.new, post:)
      Comment.update_comments_counter(post)
      expect(post.comments_counter).to be(1)
    end
  end
end
