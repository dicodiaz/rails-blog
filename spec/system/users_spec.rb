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
end
