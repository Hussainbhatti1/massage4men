class AddCcLastFourAndCardBrandToSubscriptionTransactions < ActiveRecord::Migration
  def change
    add_column :subscription_transactions, :cc_last_four, :integer
    add_column :subscription_transactions, :card_brand, :string
  end
end
