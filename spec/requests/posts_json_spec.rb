require 'swagger_helper'

describe 'Posts API' do
  path '/users/{user_id}/posts.json' do
    get 'Retrieve all posts for a given user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string

      response '200', 'Posts retrieved for given user id' do
        schema type: :object,
               properties: {
                 id: { type: :number },
                 author_id: { type: :number },
                 title: { type: :string },
                 text: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 comments_counter: { type: :number },
                 likes_counter: { type: :number }
               },
               required: %w[title]

        let(:user_id) { User.create(name: 'user name', email: 'user_mail@mail.com', password: 'user_password').id }
        run_test!
      end
    end
  end
end
