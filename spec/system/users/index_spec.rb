require 'rails_helper'

RSpec.describe User, type: :system do
  before(:each) do
    @user = User.create(name: 'user name', photo: '/assets/placeholder.png', bio: 'user bio')
    @post = Post.create(author: @user, title: 'post title', text: 'post text')
  end

  describe 'index page' do
    before(:each) do
      @user2 = User.create(name: 'user2 name', photo: '/assets/placeholder2.png', bio: 'user2 bio')
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
end
