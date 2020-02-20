class MakeAdPhotoPrimaryDefaultFalse < ActiveRecord::Migration
  def change
    change_column :ad_photos, :primary, :boolean, default: false
  end
end
