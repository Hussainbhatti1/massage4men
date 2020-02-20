class AddSlugToMasseurs < ActiveRecord::Migration
  def change
    add_column :masseurs, :slug, :string
    add_index :masseurs, :slug, unique: true
  end
end
