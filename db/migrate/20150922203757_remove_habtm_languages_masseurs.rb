class RemoveHabtmLanguagesMasseurs < ActiveRecord::Migration
  def change
    drop_join_table :masseurs, :languages do |t|
      # t.index [:masseur_id, :language_id]
      # t.index [:language_id, :masseur_id]
    end
  end
end
