class ChangeDobOnClientsToDate < ActiveRecord::Migration
  def up
    change_column :clients, :dob, 'date USING CAST(dob AS date)'
  end
  
  def down
    change_column :clients, :dob, 'string USING CAST(dob AS string)'    
  end
end
