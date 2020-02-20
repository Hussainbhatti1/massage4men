class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|
      t.string :code
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :active

      t.timestamps null: false
    end
  end
end
