class AddConversionStatsToTrackingLinks < ActiveRecord::Migration
  def change
    add_column :tracking_links, :converted, :boolean, default: false
    add_column :tracking_links, :converted_at, :datetime
  end
end
