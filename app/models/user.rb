class User < ApplicationRecord
  include ::HasSettingsConcern

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :rooms
  has_many :bookings

  def admin?
    admin
  end

  def self.current
    find(CurrentScope.user_id) if CurrentScope.user_id
  end
end
