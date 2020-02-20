class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :client, index: true, foreign_key: true
      t.references :masseur, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
