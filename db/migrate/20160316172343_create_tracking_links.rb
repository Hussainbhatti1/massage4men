class CreateTrackingLinks < ActiveRecord::Migration
  def change
    create_table :tracking_links do |t|
      t.string :code
      t.string :source

      t.timestamps null: false
    end
  end
end
