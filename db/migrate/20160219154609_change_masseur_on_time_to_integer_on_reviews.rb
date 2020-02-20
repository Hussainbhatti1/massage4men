class ChangeMasseurOnTimeToIntegerOnReviews < ActiveRecord::Migration
  def up
    # fucked-up syntax for postgres
    # http://makandracards.com/makandra/18691-postgresql-vs-rails-migration-how-to-change-columns-from-string-to-integer
    change_column :reviews, :masseur_on_time, 'integer USING CAST(masseur_on_time AS integer)'
  end
  
  def down
    change_column :reviews, :masseur_on_time, 'boolean USING CAST(masseur_on_time AS boolean)'    
  end
end
