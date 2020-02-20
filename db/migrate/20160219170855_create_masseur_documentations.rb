class CreateMasseurDocumentations < ActiveRecord::Migration
  def change
    create_table :masseur_documentations do |t|
      t.references :masseur, index: true, foreign_key: true
      t.datetime :certification_submitted
      t.boolean :certification_approved
      t.datetime :license_submitted
      t.boolean :license_approved
      t.datetime :photo_id_submitted
      t.boolean :photo_id_approved

      t.timestamps null: false
    end
  end
end
