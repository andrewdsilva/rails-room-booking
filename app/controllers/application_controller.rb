class ApplicationController < ActionController::Base
  layout :set_layout

  include ::Pundit::Authorization
  include ::PageConcern
  include ::LocaleConcern
  include ::AuthConcern

  before_action :set_current_scope

  def set_layout
    "base"
  end
end
