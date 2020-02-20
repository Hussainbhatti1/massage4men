class AddFieldsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :times_seen, :integer
    add_column :reviews, :appointment_date, :date
    add_column :reviews, :appointment_location, :string
    add_column :reviews, :appointment_scheduled_length, :integer
    add_column :reviews, :appointment_actual_length, :integer
    add_column :reviews, :masseur_on_time, :boolean
    add_column :reviews, :masseur_notified_of_lateness, :boolean
    add_column :reviews, :incall_or_outcall, :integer
    add_column :reviews, :service_as_requested, :integer
    add_column :reviews, :masseur_appearance, :integer
    add_column :reviews, :masseur_personality, :integer
    add_column :reviews, :likelihood_to_rebook, :integer
    add_column :reviews, :likelihood_to_refer, :integer
  end
end
