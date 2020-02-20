class ChangeStartAndEndDatesToDatesOnPromoCodes < ActiveRecord::Migration
  def change
    change_column :promo_codes, :start_date, :date
    change_column :promo_codes, :end_date, :date
  end
end
