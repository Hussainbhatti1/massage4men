class AddMissingImpressionistColumn < ActiveRecord::Migration
  def up
    add_column :impressions, :params, :text
    add_index :impressions, [:impressionable_type, :impressionable_id, :params], :name => "poly_params_request_index", :unique => false
  end

  def down
    remove_column :impressions, :params
  end
end
