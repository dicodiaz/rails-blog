require 'swagger_helper'

describe 'Login API' do
  path '/users/sign_in.json' do
    post 'Logs in user' do
      tags :Login
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        }
      }

      response '200', 'Logged' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        let(:user) { { email: 'user_email@mail.com', password: 'user_password' } }
        run_test!
      end
    end
  end
end
