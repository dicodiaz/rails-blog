require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Dico Diaz') }

  context 'validations' do
    before(:each) { subject.save }

    it('should be valid') { expect(subject).to be_valid }

    it 'should be invalid when name is not present' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'should be invalid when posts_counter is less than zero' do
      subject.posts_counter = -1
      expect(subject).not_to be_valid
    end
  end

  context '#three_most_recent_posts' do
    before(:each) do
      @post1 = Post.create(author: subject, title: 'Title')
      @post2 = Post.create(author: subject, title: 'Title2')
    end

    it "should return all the user's posts when there are 3 or fewer, sorted from newest to oldest" do
      posts = subject.three_most_recent_posts
      expect(posts).to eq([@post2, @post1])
    end

    it "should return the user's 3 most recent posts when there more than 3, sorted from newest to oldest" do
      post3 = Post.create(author: subject, title: 'Title3')
      post4 = Post.create(author: subject, title: 'Title4')
      posts = subject.three_most_recent_posts
      expect(posts).to eq([post4, post3, @post2])
    end
  end
end
