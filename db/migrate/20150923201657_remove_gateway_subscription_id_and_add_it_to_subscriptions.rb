class RemoveGatewaySubscriptionIdAndAddItToSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscription_transactions, :gateway_subscription_id, :string
    add_column :subscriptions, :gateway_subscription_id, :string
  end
end
