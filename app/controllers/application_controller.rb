class ApplicationController < ActionController::API
  def authenticate
    token = request.headers['Authorization']
    payload = JWT.decode(token, secret)[0]
    user_id = payload['user_id']
    @current_user = User.find(user_id)
  rescue StandardError => e
    render json: { message: "Error: #{e}" }, status: :forbidden
  end

  def secret
     ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
  end

  def create_token(payload)
    JWT.encode(payload, secret)
  end
end
