class CreateSubscriptionTransactions < ActiveRecord::Migration
  def change
    create_table :subscription_transactions do |t|
      t.references :subscription, index: true, foreign_key: true
      t.float :amount
      t.string :transaction_id
      t.string :action
      t.boolean :success
      t.text :serialized_response

      t.timestamps null: false
    end
  end
end
