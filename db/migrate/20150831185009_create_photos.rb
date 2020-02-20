class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :masseur, index: true, foreign_key: true
      t.boolean :adult, default: false
      t.boolean :approved, default: false

      t.timestamps null: false
    end
  end
end
