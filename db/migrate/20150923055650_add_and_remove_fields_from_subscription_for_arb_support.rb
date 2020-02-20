class AddAndRemoveFieldsFromSubscriptionForArbSupport < ActiveRecord::Migration
  def change
    remove_column :subscription_transactions, :action, :string if column_exists? :subscription_transactions, :action
    remove_column :subscription_transactions, :transaction_id, :string if column_exists? :subscription_transactions, :transaction_id
    
    add_column :subscription_transactions, :gateway_subscription_id, :string
  end
end
