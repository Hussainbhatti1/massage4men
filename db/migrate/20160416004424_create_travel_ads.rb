class CreateTravelAds < ActiveRecord::Migration
  def change
    create_table :travel_ads do |t|
      t.references :masseur, index: true, foreign_key: true
      t.references :massage_type, index: true, foreign_key: true
      t.text :about_me
      t.text :about_my_services
      t.string :city
      t.string :state
      t.string :country
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
