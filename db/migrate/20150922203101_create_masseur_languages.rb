class CreateMasseurLanguages < ActiveRecord::Migration
  def change
    create_table :masseur_languages do |t|
      t.references :masseur, index: true, foreign_key: true
      t.references :language, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
