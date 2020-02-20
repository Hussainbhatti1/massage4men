class CreateAdPhotos < ActiveRecord::Migration
  def change
    create_table :ad_photos do |t|
      t.references :ad, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true
      t.integer :display_order

      t.timestamps null: false
    end
  end
end
