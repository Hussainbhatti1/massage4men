class AddApprovedToMasseurs < ActiveRecord::Migration
  def change
    add_column :masseurs, :approved, :boolean
  end
end
