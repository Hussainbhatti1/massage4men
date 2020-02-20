class CreateSexualOrientations < ActiveRecord::Migration
  def change
    create_table :sexual_orientations do |t|
      t.string :orientation

      t.timestamps null: false
    end
  end
end
