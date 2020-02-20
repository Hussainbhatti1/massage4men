class CreateMassageTypes < ActiveRecord::Migration
  def change
    create_table :massage_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
