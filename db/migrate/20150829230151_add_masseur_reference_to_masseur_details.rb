class AddMasseurReferenceToMasseurDetails < ActiveRecord::Migration
  def change
    add_reference :masseur_details, :masseur, index: true, foreign_key: true
  end
end
