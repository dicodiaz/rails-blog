require 'rails_helper'

RSpec.describe Post, type: :system do
  before(:each) do
    @user = User.create(name: 'user name', photo: '/assets/placeholder.png', bio: 'user bio')
    @post = Post.create(author: @user, title: 'post title', text: 'post text')
    @comment = Comment.create(author: @user, post: @post, text: 'comment text')
    Like.create(author: @user, post: @post)
  end

  describe 'index page' do
    before(:each) do
      visit user_posts_path(@user)
    end

    it "displays the user's profile picture" do
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    it "displays the user's username" do
      expect(page).to have_content(@user.name)
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content("Number of posts: #{@user.posts.size}")
    end

    it "displays a post's title" do
      expect(page).to have_content(@post.title)
    end

    it "displays some of the post's body" do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@post.text)
    end

    it "displays the post's 5 most recent comments" do
      comment2 = Comment.create(author: @user, post: @post, text: 'comment2 text')
      comment3 = Comment.create(author: @user, post: @post, text: 'comment3 text')
      comment4 = Comment.create(author: @user, post: @post, text: 'comment4 text')
      comment5 = Comment.create(author: @user, post: @post, text: 'comment5 text')
      comment6 = Comment.create(author: @user, post: @post, text: 'comment6 text')
      refresh
      expect(page).to have_content(comment2.text)
      expect(page).to have_content(comment3.text)
      expect(page).to have_content(comment4.text)
      expect(page).to have_content(comment5.text)
      expect(page).to have_content(comment6.text)
      expect(page).not_to have_content(@comment.text)
    end

    it 'displays how many comments a post has' do
      expect(page).to have_content("Comments: #{@post.comments.size}")
    end

    it 'displays how many likes a post has' do
      expect(page).to have_content("Comments: #{@post.likes.size}")
    end

    it "redirects to a post's show page when clicking on it" do
      click_link(@post.title)
      expect(page).to have_current_path(user_post_path(@user, @post))
    end
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
