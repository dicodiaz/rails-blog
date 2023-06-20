require 'rails_helper'

RSpec.describe User, type: :system do
  before(:each) do
    @user1 = User.create(name: 'Dico Diaz', photo: '/assets/Dico.jpg', bio: 'Mock bio')
    @user2 = User.create(name: 'Amanda Lopez', photo: '/assets/Dico2.jpg', bio: 'Mock bio 2')
  end

  describe 'index page' do
    it 'shows the username for all users' do
      visit users_path
      expect(page).to have_content('Dico Diaz')
      expect(page).to have_content('Amanda Lopez')
    end

    it 'shows the profile picture for each user' do
      visit users_path
      expect(page).to have_xpath("//img[contains(@src,'assets/Dico.jpg')]")
      expect(page).to have_xpath("//img[contains(@src,'assets/Dico2.jpg')]")
    end

    it 'shows the number of posts for each user' do
      visit users_path
      expect(page).to have_content('Number of posts: 0')
      Post.create(author: @user1, title: 'Title', text: 'text')
      Post.create(author: @user1, title: 'Title2', text: 'text2')
      visit users_path
      expect(page).to have_content('Number of posts: 2')
    end

    it "redirects to a user show page when clicking on it's card" do
      visit users_path
      click_link(@user1.name)
      expect(page).to have_current_path(user_path(@user1.id))
    end
  end

  describe 'show page' do
    before(:each) do
      Post.create(author: @user1, title: 'textitle', text: 'text')
      Post.create(author: @user1, title: 'Title2', text: 'text2')
      visit user_path(@user1)
    end

    it 'displays the user profile picture' do
      expect(page).to have_xpath("//img[contains(@src,'assets/Dico.jpg')]")
    end

    it 'displays the user username' do
      expect(page).to have_content(@user1.name)
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content('Number of posts: 2')
    end

    it 'displays the user bio' do
      expect(page).to have_content(@user1.bio)
    end

    it 'displays the first 3 posts' do
      @user1.posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'displays a button to view all of a user\'s posts' do
      expect(page).to have_link('See all posts', href: user_posts_path(@user1))
    end

    it 'redirects to the post show page when a post is clicked' do
      post = @user1.posts.first
      click_link post.title
      expect(page).to have_current_path(user_post_path(@user1.id, post.id))
    end

    it 'redirects to the user posts index page when "See all posts" is clicked' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user1))
    end
  end
end
