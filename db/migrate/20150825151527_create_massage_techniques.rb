class CreateMassageTechniques < ActiveRecord::Migration
  def change
    create_table :massage_techniques do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
