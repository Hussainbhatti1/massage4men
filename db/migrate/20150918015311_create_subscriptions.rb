class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :masseur, index: true, foreign_key: true
      t.references :promo_code, index: true, foreign_key: true
      t.integer :type
      t.boolean :active

      t.timestamps null: false
    end
  end
end
