class AddScreenNameToClients < ActiveRecord::Migration
  def change
    add_column :clients, :screen_name, :string
  end
end
