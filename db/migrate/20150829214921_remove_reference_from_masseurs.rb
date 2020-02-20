class RemoveReferenceFromMasseurs < ActiveRecord::Migration
  def change
    remove_reference :masseurs, :masseur_detail, index: true
  end
end
