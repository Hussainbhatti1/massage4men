class CreateJoinTableMassageTechniquesMasseurDetails < ActiveRecord::Migration
  def change
    create_join_table :massage_techniques, :masseur_details do |t|
      # t.index [:massage_technique_id, :masseur_detail_id]
      # t.index [:masseur_detail_id, :massage_technique_id]
    end
  end
end
