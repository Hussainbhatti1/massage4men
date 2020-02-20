class DeviseCreateMasseurs < ActiveRecord::Migration
  def change
    create_table(:masseurs) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.references :masseur_detail
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :mailing_address
      t.string :mailing_unit
      t.string :mailing_city
      t.string :mailing_state
      t.string :mailing_zip
      t.date :dob
      t.string :contact_phone
      t.string :contact_phone_type

      t.timestamps null: false
    end

    add_index :masseurs, :email,                unique: true
    add_index :masseurs, :reset_password_token, unique: true
    # add_index :masseurs, :confirmation_token,   unique: true
    # add_index :masseurs, :unlock_token,         unique: true
  end
end
