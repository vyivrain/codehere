class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request

  def index
    users = User.all
    render json: users, status: :ok
  end

  def show
    render json: user, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  def create
    user = User.new(user_params)
    if user.save
      WelcomeMailer.welcome_email(user).deliver_now
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def destroy
    user.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

  def user
    @user = User.find(params[:id])
  end
end
