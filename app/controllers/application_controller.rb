class ApplicationController < ActionController::Base
  layout :set_layout

  def set_layout
    "base"
  end
end
