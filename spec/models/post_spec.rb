require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(name: 'user name', photo: '/assets/placeholder.png', bio: 'user bio')
    @post = Post.create(author: @user, title: 'post title', text: 'post text')
  end

  context 'validations' do
    it('should be valid') do
      expect(@post).to be_valid
    end

    it 'should be invalid when title is present' do
      @post.title = nil
      expect(@post).not_to be_valid
    end

    it 'should be invalid when title exceeds 250 characters' do
      @post.title = 'a' * 251
      expect(@post).not_to be_valid
    end

    it 'should be invalid when comments_counter is less than zero' do
      @post.comments_counter = -1
      expect(@post).not_to be_valid
    end

    it 'should be invalid when likes_counter is less than zero' do
      @post.likes_counter = -1
      expect(@post).not_to be_valid
    end
  end

  context '#five_most_recent_comments' do
    before(:each) do
      @comment1 = Comment.create(author: @user, post: @post)
      @comment2 = Comment.create(author: @user, post: @post)
      @comment3 = Comment.create(author: @user, post: @post)
      @comment4 = Comment.create(author: @user, post: @post)
    end

    it "should return all the post's comments when there are 5 or fewer, sorted from newest to oldest" do
      comments = @post.five_most_recent_comments
      expect(comments).to eq([@comment1, @comment2, @comment3, @comment4])
    end

    it "should return the post's 5 most recent comments when there more than 5, sorted from newest to oldest" do
      comment5 = Comment.create(author: @user, post: @post)
      comment6 = Comment.create(author: @user, post: @post)
      comments = @post.five_most_recent_comments
      expect(comments).to eq([@comment2, @comment3, @comment4, comment5, comment6])
    end
  end

  context '::update_posts_counter' do
    it 'should update the posts_counter for a given user' do
      Post.update_posts_counter(@user)
      expect(@user.posts_counter).to be(1)
    end
  end
end
