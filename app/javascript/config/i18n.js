const userLocale = getLocale();

fetch("/locale/" + userLocale + "/translations.json")
  .then((response) => response.json())
  .then((json) => {
    window.i18n = new I18n.I18n(json);

    window.i18n.locale = userLocale;
  }
);
