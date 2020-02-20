class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :masseur_detail, index: true, foreign_key: true
      t.integer :type
      t.integer :rate
      t.string :time
      t.text :description

      t.timestamps null: false
    end
  end
end
