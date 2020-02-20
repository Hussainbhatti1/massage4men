class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.references :masseur, index: true, foreign_key: true
      t.references :promo_code, index: true, foreign_key: true
      t.integer :subscription_type
      t.boolean :active
      t.boolean :fourteen_day_email_sent
      t.boolean :seven_day_email_sent
      t.datetime :ends_at

      t.timestamps null: false
    end
  end
end
