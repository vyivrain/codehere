class User < ApplicationRecord
  has_many :projects

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def generate_jwt
    payload = {
      user_id: id,
      exp: 24.hours.from_now.to_i
    }
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
