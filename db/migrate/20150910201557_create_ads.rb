class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.references :masseur, index: true, foreign_key: true
      t.string :type

      t.timestamps null: false
    end
  end
end
