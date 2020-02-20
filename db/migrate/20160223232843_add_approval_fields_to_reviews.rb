class AddApprovalFieldsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :masseur_approved, :boolean, default: false
    add_column :reviews, :admin_approved, :boolean, default: false
  end
end
