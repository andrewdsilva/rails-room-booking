class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :rooms
  has_many :bookings

  def admin?
    admin
  end
end
