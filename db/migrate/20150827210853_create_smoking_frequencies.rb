class CreateSmokingFrequencies < ActiveRecord::Migration
  def change
    create_table :smoking_frequencies do |t|
      t.string :frequency

      t.timestamps null: false
    end
  end
end
