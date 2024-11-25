class User < ApplicationRecord
  has_many :projects

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
