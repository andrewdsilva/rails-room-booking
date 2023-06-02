class RoomPolicy < ApplicationPolicy

  def update?
    super && @record.user == @user
  end

end
