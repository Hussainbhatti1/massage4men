class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :client, index: true, foreign_key: true
      t.references :masseur, index: true, foreign_key: true
      t.text :review

      t.timestamps null: false
    end
  end
end
