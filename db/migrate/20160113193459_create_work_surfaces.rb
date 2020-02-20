class CreateWorkSurfaces < ActiveRecord::Migration
  def change
    create_table :work_surfaces do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
