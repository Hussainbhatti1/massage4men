class DropObsoleteTables < ActiveRecord::Migration
  def change
    drop_table :users
    drop_join_table :languages, :users
  end
end
