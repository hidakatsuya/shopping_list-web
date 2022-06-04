class User < ApplicationRecord
  devise :database_authenticatable, :validatable
  has_many :items, dependent: :destroy
end
