module HasPriceConcern
  extend ActiveSupport::Concern

  included do
    before_save :set_price_ht, :set_price_ttc, if: :start_or_end_changed?
  end

  def compute_price_ht
    room.day_price * (end_date - start_date).to_i
  end

  def vat
    room.user.setting.vat || 0.2
  end

  def compute_price_ttc
    total_ht * (1 + vat)
  end

  def set_price_ht
    self.total_ht = compute_price_ht
  end

  def set_price_ttc
    self.total_ttc = compute_price_ttc
  end
end
