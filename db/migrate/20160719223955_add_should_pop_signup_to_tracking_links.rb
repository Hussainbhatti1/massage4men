class AddShouldPopSignupToTrackingLinks < ActiveRecord::Migration
  def change
    add_column :tracking_links, :should_pop_signup, :boolean, default: false
  end
end
