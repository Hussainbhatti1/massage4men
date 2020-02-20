class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
