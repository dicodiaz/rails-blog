class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    respond_to do |format|
      format.json { render json: { message: 'Logged.' }, status: :ok }
      format.any { super }
    end
  end

  def respond_to_on_destroy
    respond_to do |format|
      format.json { current_user ? log_out_success : log_out_failure }
      format.any { super }
    end
  end

  def log_out_success
    respond_to do |format|
      format.json { render json: { message: 'Logged out.' }, status: :ok }
      format.any { super }
    end
  end

  def log_out_failure
    respond_to do |format|
      format.json { render json: { message: 'Logged out failure.' }, status: :unauthorized }
      format.any { super }
    end
  end
end
