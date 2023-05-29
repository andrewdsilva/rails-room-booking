module HasOwnerConcern
  extend ActiveSupport::Concern

  included do
    before_validation :assign_owner
  end

  private

  def assign_owner
    self.user_id = User.current.id if self.user_id.nil? && User.current
  end
end
