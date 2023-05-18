module LocaleConcern
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale
    before_action :set_language_path
  end

  def language_redirection
    redirect_to "/#{locale}"
  end

  private

  def switch_locale(&action)
    cookies[:lang] = locale

    I18n.with_locale(locale, &action)
  end

  def locale
    params[:locale] || cookies[:lang] || I18n.default_locale
  end

  def set_language_path
    if request.path.match(/\/(fr|en)$/)
      @fr_path = "/fr/"
      @en_path = "/en/"
    else
      @fr_path = request.path.sub("/#{params[:locale]}/", "/fr/")
      @en_path = request.path.sub("/#{params[:locale]}/", "/en/")
    end
  end

end
