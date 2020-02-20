class MoveScreenNameToMasseurs < ActiveRecord::Migration
  def up
    add_column :masseurs, :screen_name, :string
    
    MasseurDetail.find_each do |detail|
      masseur = detail.masseur
      masseur.screen_name = detail.screen_name
      masseur.save!
    end    
    
    remove_column :masseur_details, :screen_name, :string
  end  
end
