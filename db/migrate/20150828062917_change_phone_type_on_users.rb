class ChangePhoneTypeOnUsers < ActiveRecord::Migration
  def up
    change_column :users, :phone_type, :string
  end
  
  def down
    change_column :users, :phone_type, :integer
  end
end
