class ModifyMasseurLanguageJoinTableToMoveAssociationToMasseurDetail < ActiveRecord::Migration
  def change
    remove_reference :masseur_languages, :masseur, index: true, foreign_key: true
    add_reference :masseur_languages, :masseur_detail, index: true, foreign_key: true
  end
end
