require 'rails_helper'

RSpec.describe Post, type: :system do
  before(:each) do
    @user = User.create(name: 'user name', photo: '/assets/placeholder.png', bio: 'user bio')
    @post = Post.create(author: @user, title: 'post title', text: 'post text')
    @comment = Comment.create(author: @user, post: @post, text: 'comment text')
    Like.create(author: @user, post: @post)
  end

  describe 'show page' do
    before(:each) do
      @user2 = User.create(name: 'user2 name', photo: '/assets/placeholder2.png', bio: 'user2 bio')
      @comment2 = Comment.create(author: @user2, post: @post, text: 'comment2 text')
      visit user_post_path(@user, @post)
    end

    it "displays the post's title" do
      expect(page).to have_content(@post.title)
    end

    it 'displays who wrote the post' do
      expect(page).to have_content(@user.name)
    end

    it 'displays how many comments the post has' do
      expect(page).to have_content("Comments: #{@post.comments.size}")
    end

    it 'displays how many likes the post has' do
      expect(page).to have_content("Likes: #{@post.likes.size}")
    end

    it "displays the post's body" do
      expect(page).to have_content(@post.text)
    end

    it 'displays the username of each commentor' do
      expect(page).to have_content(@comment.author.name)
      expect(page).to have_content(@comment2.author.name)
    end

    it 'displays the comment each commentor left' do
      expect(page).to have_content(@comment.text)
      expect(page).to have_content(@comment2.text)
    end
  end
end
