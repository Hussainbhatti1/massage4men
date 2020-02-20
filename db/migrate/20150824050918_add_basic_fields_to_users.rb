class AddBasicFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :dob, :date
    add_column :users, :phone, :string
    add_column :users, :phone_type, :integer
    add_column :users, :email_new_masseurs, :boolean
    add_column :users, :email_masseur_profile_update, :boolean
    add_column :users, :email_weekly_update, :boolean
  end
end
