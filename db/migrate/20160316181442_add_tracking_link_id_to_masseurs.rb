class AddTrackingLinkIdToMasseurs < ActiveRecord::Migration
  def change
    add_reference :masseurs, :tracking_link, index: true, foreign_key: true
  end
end
