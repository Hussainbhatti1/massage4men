class CreateJoinTableWorkLocationsMasseurDetails < ActiveRecord::Migration
  def change
    create_join_table :work_locations, :masseur_details do |t|
      # t.index [:work_location_id, :masseur_detail_id]
      # t.index [:masseur_detail_id, :work_location_id]
    end
  end
end
