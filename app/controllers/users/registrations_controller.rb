class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  respond_to :json

  private

  def respond_with(resource, _opts = {})
    respond_to do |format|
      format.json { resource.persisted? ? register_success : register_failed }
      format.any { super }
    end
  end

  def register_success
    respond_to do |format|
      format.json { render json: { message: 'Signed up.' } }
      format.any { super }
    end
  end

  def register_failed
    respond_to do |format|
      format.json { render json: { message: 'Signed up failure.' } }
      format.any { super }
    end
  end
end
