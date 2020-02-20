class RenameAmountToAmountChargedOnSubscriptionTransactions < ActiveRecord::Migration
  def change
    rename_column :subscription_transactions, :amount, :amount_charged
  end
end
