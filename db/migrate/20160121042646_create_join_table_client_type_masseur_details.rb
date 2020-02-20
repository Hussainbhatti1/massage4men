class CreateJoinTableClientTypeMasseurDetails < ActiveRecord::Migration
  def change
    create_join_table :client_types, :masseur_details do |t|
      # t.index [:client_type_id, :masseur_detail_id]
      # t.index [:masseur_detail_id, :client_type_id]
    end
  end
end
