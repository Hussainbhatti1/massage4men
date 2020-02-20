class RemoveHabtmClientsLanguages < ActiveRecord::Migration
  def change
    drop_join_table :clients, :languages do |t|
      # t.index [:client_id, :language_id]
      # t.index [:language_id, :client_id]
    end
  end
end
