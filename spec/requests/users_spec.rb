require 'rails_helper'

RSpec.describe '/users', type: :request do
  let!(:user) { User.create(name: 'user name', email: 'user_mail@mail.com', password: 'user_password') }

  describe 'GET /users' do
    before(:each) { get users_url }

    it('renders a successful response') { expect(response).to be_successful }
    it('renders the correct template') { expect(response).to render_template 'users/index' }
    it("includes the correct placeholder text in the response's body") {
      expect(response.body).to include('post')
    }
  end

  describe 'GET /users/:id' do
    before(:each) { get user_url(user) }

    it('renders a successful response') { expect(response).to be_successful }
    it('renders the correct template') { expect(response).to render_template 'users/show' }
    it("includes the correct placeholder text in the response's body") {
      expect(response.body).to include(user.name)
    }
  end
end
