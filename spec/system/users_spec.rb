require 'rails_helper'

RSpec.describe User, type: :system do
  before(:each) do
    @user = User.create(name: 'user name', photo: '/assets/placeholder.png', bio: 'user bio',
                        email: 'user_mail@mail.com', password: 'user_password')
    @post = Post.create(author: @user, title: 'post title', text: 'post text')
  end

  describe 'index page' do
    before(:each) do
      @user2 = User.create(name: 'user2 name', photo: '/assets/placeholder2.png', bio: 'user2 bio',
                           email: 'user2_mail@mail.com', password: 'user2_password')
      visit users_path
    end

    it 'displays the username for all users' do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user2.name)
    end

    it 'displays the profile picture for each user' do
      expect(page).to have_css("img[src*='#{@user.photo}']")
      expect(page).to have_css("img[src*='#{@user2.photo}']")
    end

    it 'displays the number of posts each user has written' do
      expect(page).to have_content("Number of posts: #{@user.posts.size}")
    end

    it "redirects to a user's show page when clicking on it" do
      click_link(@user.name)
      expect(page).to have_current_path(user_path(@user))
    end
  end

  describe 'show page' do
    before(:each) do
      visit user_path(@user)
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

    it "displays the user's bio" do
      expect(page).to have_content(@user.bio)
    end

    it "displays the user's 3 most recent posts" do
      post2 = Post.create(author: @user, title: 'post2 title')
      post3 = Post.create(author: @user, title: 'post3 title')
      post4 = Post.create(author: @user, title: 'post4 title')
      refresh
      expect(page).to have_content(post2.title)
      expect(page).to have_content(post3.title)
      expect(page).to have_content(post4.title)
      expect(page).not_to have_content(@post.title)
    end

    it "displays a button to view all of the user's posts" do
      expect(page).to have_link('See all posts', href: user_posts_path(@user))
    end

    it "redirects to a post's show page when clicking on it" do
      click_link(@post.title)
      expect(page).to have_current_path(user_post_path(@user, @post))
    end

    it "redirects to the user's post's index page when clicking on 'See all posts'" do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
