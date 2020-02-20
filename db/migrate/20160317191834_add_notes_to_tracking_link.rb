class AddNotesToTrackingLink < ActiveRecord::Migration
  def change
    add_column :tracking_links, :notes, :text
  end
end
