class AddNotesToReviews < ActiveRecord::Migration
  def change
    add_column :masseur_documentations, :certification_notes, :text
    add_column :masseur_documentations, :license_notes, :text
    add_column :masseur_documentations, :photo_id_notes, :text
  end
end
