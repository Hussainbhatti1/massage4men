class AddPromoCodeReferenceToTrackingLinks < ActiveRecord::Migration
  def change
    add_reference :tracking_links, :promo_code, index: true, foreign_key: true
  end
end
