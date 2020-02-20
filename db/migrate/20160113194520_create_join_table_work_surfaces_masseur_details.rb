class CreateJoinTableWorkSurfacesMasseurDetails < ActiveRecord::Migration
  def change
    create_join_table :work_surfaces, :masseur_details do |t|
      # t.index [:work_surface_id, :masseur_detail_id]
      # t.index [:masseur_detail_id, :work_surface_id]
    end
  end
end
