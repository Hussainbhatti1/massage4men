class CreateJoinTableLanguageUser < ActiveRecord::Migration
  # http://stackoverflow.com/questions/4381154/rails-migration-for-has-and-belongs-to-many-join-table
  def change
    create_join_table :languages, :users do |t|
      # t.index [:language_id, :user_id]
      # t.index [:user_id, :language_id]
    end
  end
end
