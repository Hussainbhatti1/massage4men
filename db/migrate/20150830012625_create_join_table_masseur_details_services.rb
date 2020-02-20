class CreateJoinTableMasseurDetailsServices < ActiveRecord::Migration
  def change
    create_join_table :masseur_details, :services do |t|
      # t.index [:masseur_detail_id, :service_id]
      # t.index [:service_id, :masseur_detail_id]
    end
  end
end
