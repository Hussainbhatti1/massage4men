class CreateMassageTypesMasseurDetailsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :massage_types, :masseur_details do |t|
      # t.index [:massage_type_id, :masseur_detail_id]
      # t.index [:masseur_detail_id, :massage_type_id]
    end
  end
end
