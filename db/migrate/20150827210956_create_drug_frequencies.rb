class CreateDrugFrequencies < ActiveRecord::Migration
  def change
    create_table :drug_frequencies do |t|
      t.string :frequency

      t.timestamps null: false
    end
  end
end
