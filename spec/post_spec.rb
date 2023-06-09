require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(author: User.new, title: 'Title') }

  context 'validations' do
    before(:each) { subject.save }

    it('should be valid') { expect(subject).to be_valid }

    it 'should be invalid when title is present' do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it 'should be invalid when title exceeds 250 characters' do
      subject.title = 'a' * 251
      expect(subject).not_to be_valid
    end

    it 'should be invalid when comments_counter is less than zero' do
      subject.comments_counter = -1
      expect(subject).not_to be_valid
    end

    it 'should be invalid when likes_counter is less than zero' do
      subject.likes_counter = -1
      expect(subject).not_to be_valid
    end
  end

  context '#five_most_recent_comments' do
    before(:each) do
      @comment1 = Comment.create(author: User.new, post: Post.new)
      @comment2 = Comment.create(author: User.new, post: Post.new)
      @comment3 = Comment.create(author: User.new, post: Post.new)
      @comment4 = Comment.create(author: User.new, post: Post.new)
    end

    it "should return all the post's comments when there are 5 or fewer, sorted from newest to oldest" do
      comments = subject.five_most_recent_comments
      expect(comments).to eq([@comment4, @comment3, @comment2, @comment1])
    end

    it "should return the post's 5 most recent comments when there more than 5, sorted from newest to oldest" do
      comment5 = Comment.create(author: User.new, post: Post.new)
      comment6 = Comment.create(author: User.new, post: Post.new)
      comments = subject.five_most_recent_comments
      expect(comments).to eq([comment6, comment5, @comment4, @comment3, @comment2])
    end
  end

  context '::update_posts_counter' do
    it 'should update the posts_counter for a given user' do
      user = User.new(name: 'Dico Diaz')
      Post.create(author: user, title: 'Title')
      Post.update_posts_counter(user)
      expect(user.posts_counter).to be(1)
    end
  end
end
