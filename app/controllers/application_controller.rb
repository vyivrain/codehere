class ApplicationController < ActionController::API
  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      decoded = JWT.decode(header, Rails.application.credentials.secret_key_base)
      @current_user = User.find(decoded.first['user_id'])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    rescue JWT::ExpiredSignature
      render json: { error: 'Token expired' }, status: :unauthorized
    end
  end
end
