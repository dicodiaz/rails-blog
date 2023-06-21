require 'rails_helper'

RSpec.describe '/posts', type: :request do
  let!(:user) { User.create(name: 'Dico Diaz') }
  let!(:post) { Post.create(author: user, title: 'Title') }

  describe 'GET /users/:user_id/posts' do
    before(:each) { get user_posts_url(user.id) }

    it('renders a successful response') { expect(response).to be_successful }
    it('renders the correct template') { expect(response).to render_template 'posts/index' }
    it("includes the correct placeholder text in the response's body") {
      expect(response.body).to include(user.name)
    }
  end

  describe 'GET /users/:user_id/posts/:id' do
    before(:each) { get user_post_url(user.id, post.id) }

    it('renders a successful response') { expect(response).to be_successful }
    it('renders the correct template') { expect(response).to render_template 'posts/show' }
    it("includes the correct placeholder text in the response's body") {
      expect(response.body).to include(post.title)
    }
  end
end
