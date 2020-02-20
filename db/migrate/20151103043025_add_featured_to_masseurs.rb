class AddFeaturedToMasseurs < ActiveRecord::Migration
  def change
    add_column :masseurs, :featured, :boolean
  end
end
