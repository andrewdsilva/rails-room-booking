module AuthConcern
  def set_current_scope
    extend ActiveSupport::Concern

    CurrentScope.user_id = current_user.id if current_user.present?
  end
end
