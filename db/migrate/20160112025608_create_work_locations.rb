class CreateWorkLocations < ActiveRecord::Migration
  def change
    create_table :work_locations do |t|

      t.timestamps null: false
    end
  end
end
