require 'rails_helper'

RSpec.describe Like, type: :model do
  context '::update_likes_counter' do
    it 'should update the likes_counter for a given post' do
      post = Post.new(author: User.new, title: 'Title')
      Like.create(author: User.new, post:)
      Like.update_likes_counter(post)
      expect(post.likes_counter).to be(1)
    end
  end
end
