require 'swagger_helper'

describe 'Posts API' do
  path '/posts/{post_id}/comments.json' do
    get 'Retrieve all comments for a given post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :post_id, in: :path, type: :string

      response '200', 'Comments retrieved for given post id' do
        schema type: :object,
               properties: {
                 id: { type: :number },
                 author_id: { type: :number },
                 post_id: { type: :number },
                 text: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[author_id post_id]

        run_test!
      end
    end
  end

  path '/api/v1/pets' do
    post 'Creates a pet' do
      tags 'Comments'
      consumes 'application/json', 'application/xml'
      parameter name: :pet, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          photo_url: { type: :string },
          status: { type: :string }
        },
        required: %w[name status]
      }

      response '201', 'pet created' do
        let(:pet) { { name: 'Dodo', status: 'available' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:pet) { { name: 'foo' } }
        run_test!
      end
    end
  end
end
