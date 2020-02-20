class ChangeRateToStringOnRates < ActiveRecord::Migration
  def change
    change_column :rates, :rate, :string
  end
end
