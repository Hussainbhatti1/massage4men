class AddIsDeletedToMasseurs < ActiveRecord::Migration
  def change
    add_column :masseurs, :is_deleted, :boolean,default: false
  end
end
