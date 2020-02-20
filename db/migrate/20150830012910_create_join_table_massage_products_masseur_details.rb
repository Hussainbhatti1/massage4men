class CreateJoinTableMassageProductsMasseurDetails < ActiveRecord::Migration
  def change
    create_join_table :massage_products, :masseur_details do |t|
      # t.index [:massage_product_id, :masseur_detail_id]
      # t.index [:masseur_detail_id, :massage_product_id]
    end
  end
end
