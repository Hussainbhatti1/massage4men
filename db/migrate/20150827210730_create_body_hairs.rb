class CreateBodyHairs < ActiveRecord::Migration
  def change
    create_table :body_hairs do |t|
      t.string :hairiness

      t.timestamps null: false
    end
  end
end
