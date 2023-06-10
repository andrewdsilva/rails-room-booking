module HasSettingsConcern
  extend ActiveSupport::Concern

  included do
    after_create :create_setting

    has_one :setting
  end
end
