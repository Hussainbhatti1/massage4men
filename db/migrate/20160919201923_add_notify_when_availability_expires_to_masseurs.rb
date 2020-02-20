class AddNotifyWhenAvailabilityExpiresToMasseurs < ActiveRecord::Migration
  def change
    add_column :masseurs, :notify_when_availability_expires, :boolean, default: true
  end
end
