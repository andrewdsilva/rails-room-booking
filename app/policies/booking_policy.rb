class BookingPolicy < ApplicationPolicy
  def update?
    super && @record.user == @user
  end

  def cancel?
    update?
  end
end
