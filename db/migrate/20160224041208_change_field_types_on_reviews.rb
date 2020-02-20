class ChangeFieldTypesOnReviews < ActiveRecord::Migration
  def up
    change_column :reviews, :times_seen, 'varchar USING CAST(times_seen AS varchar)'
    change_column :reviews, :appointment_scheduled_length, 'varchar USING CAST(appointment_scheduled_length AS varchar)'
    change_column :reviews, :appointment_actual_length, 'varchar USING CAST(appointment_actual_length AS varchar)'
    change_column :reviews, :masseur_on_time, 'varchar USING CAST(masseur_on_time AS varchar)'
    change_column :reviews, :service_as_requested, 'varchar USING CAST(service_as_requested AS varchar)'    
  end
  
  def down
    change_column :reviews, :times_seen, 'integer USING CAST(times_seen AS integer)'
    change_column :reviews, :appointment_scheduled_length, 'integer USING CAST(appointment_scheduled_length AS integer)'
    change_column :reviews, :appointment_actual_length, 'integer USING CAST(appointment_actual_length AS integer)'
    change_column :reviews, :masseur_on_time, 'integer USING CAST(masseur_on_time AS integer)'
    change_column :reviews, :service_as_requested, 'integer USING CAST(service_as_requested AS integer)'    
  end
end
