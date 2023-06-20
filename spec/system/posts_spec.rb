require 'rails_helper'

RSpec.describe Post, type: :system do
  before(:all) do
    @user = User.create(name: 'Dico Diaz', photo: '/assets/Dico.jpg', bio: 'user bio')
    @post = Post.create(author: @user, title: 'post title', text: 'post body')
    @comment = Comment.create(author: @user, post: @post, text: 'comment body')
    Like.create(author: @user, post: @post)
  end

  describe 'index page' do
    it "shows the user's profile picture" do
      visit user_posts_path(@user.id)
      expect(page).to have_xpath("//img[contains(@src,'/assets/Dico.jpg')]")
    end

    it "shows the user's username" do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@user.name)
    end

    it 'shows the number of posts the user has written' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Number of posts: 1')
    end

    it "shows a post's title" do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@post.title)
    end

    it "shows some of the post's body" do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@post.text)
    end

    it 'shows the first comments on a post' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@comment.text)
    end

    it 'shows how many comments a post has' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Comments: 1')
    end

    it 'shows how many likes a post has' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Likes: 1')
    end

    it "redirects to a post's show page when clicking on it" do
      visit user_posts_path(@user.id)
      click_link(@post.title)
      expect(page).to have_current_path(user_post_path(@user.id, @post.id))
    end
  end
end
