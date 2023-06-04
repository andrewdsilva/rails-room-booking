class BookingPolicy < ApplicationPolicy
  def update?
    super && @record.user == @user
  end
end
