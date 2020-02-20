class RemoveWorkSurfaceFromMasseurDetailsSoWeCanMakeItAnAssociation < ActiveRecord::Migration
  def change
    remove_column :masseur_details, :work_surface
  end
end
