require 'swagger_helper'

describe 'Comments API' do
  path '/posts/{post_id}/comments.json' do
    post 'Creates a comment for a given post' do
      tags :Comments
      security [Bearer: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :post_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        }
      }

      response '201', 'Post created' do
        schema type: :object,
               properties: {
                 id: { type: :number },
                 author_id: { type: :number },
                 post_id: { type: :number },
                 text: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               }

        let(:post) do
          {
            id: 1,
            author_id: 1,
            post_id: 1,
            text: 'post text',
            created_at: '2023-06-25T02:51:17.237Z',
            updated_at: '2023-06-25T02:51:17.237Z'
          }
        end
        run_test!
      end

      response '401', 'Unauthorized' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        let(:post) { { error: 'You need to sign in or sign up before continuing.' } }
        run_test!
      end

      response '422', 'Invalid request' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        let(:post) { { error: 'Author must exist and Post must exist' } }
        run_test!
      end
    end
  end

  path '/posts/{post_id}/comments.json' do
    get 'Retrieves all comments for a given post' do
      tags :Comments
      produces 'application/json'
      parameter name: :post_id, in: :path, type: :string

      response '200', 'Comments retrieved for the given post' do
        schema type: :object,
               properties: {
                 id: { type: :number },
                 author_id: { type: :number },
                 post_id: { type: :number },
                 text: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               }

        let(:user) { User.create(name: 'user name', email: 'user_mail@mail.com', password: 'user_password') }
        let(:post_id) { Post.create(author: user, title: 'post title', text: 'post text').id }
        run_test!
      end

      response '404', 'Post not found' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        let(:post_id) { 'invalid' }
        run_test!
      end
    end
  end
end
