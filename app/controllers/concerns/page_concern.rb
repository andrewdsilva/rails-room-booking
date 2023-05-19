module PageConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_page_variables
  end

  private

  def page_title
    I18n.t("#{controller_name}.#{action_name}_title")
  end

  def page_description
    I18n.t("#{controller_name}.#{action_name}_description")
  end

  def set_page_variables
    @page_title ||= page_title
    @page_description ||= page_description
    @page_url = "#{DOMAIN_NAME}#{request.path}"
    @page_lang = locale
  end
end
