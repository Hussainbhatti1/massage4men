class CreateMassageProducts < ActiveRecord::Migration
  def change
    create_table :massage_products do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
