class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email], password: params[:password])

    # Authenticate user
    if user
      # Generate JWT token
      token = user.generate_jwt

      render json: {
        token: token,
        user: user.as_json(except: [:password])
      }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
