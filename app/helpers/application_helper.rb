module ApplicationHelper
  def currency_str(ammount)
    format = I18n.t :format, scope: "number.currency.format"
    Money.from_amount(ammount, "EUR").format(format: format)
  end
end
