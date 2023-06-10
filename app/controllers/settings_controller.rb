class SettingsController < ApplicationController
  include ::CrudConcern

  private

  def base_class
    ::Setting
  end

  def object_class
    return base_class.none if current_user.nil?

    base_class.all.where(user_id: current_user.id)
  end

  def strong_params
    [
      :vat
    ]
  end

  def model_params
    :setting
  end

  def use_slug?
    false
  end

  def set_object
    @object = current_user.setting
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def redirect_to_show(_object)
    redirect_to settings_path
  end
end
