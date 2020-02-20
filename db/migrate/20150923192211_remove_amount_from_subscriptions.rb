class RemoveAmountFromSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :amount, :integer
  end
end
