class ApplicationController < ActionController::Base
  layout :set_layout

  include ::Pundit::Authorization
  include ::PageConcern
  include ::LocaleConcern

  def set_layout
    "base"
  end
end
