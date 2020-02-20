class AddDetailReferencesToMasseurDetails < ActiveRecord::Migration
  def change
    add_reference :masseur_details, :build, index: true, foreign_key: true
    add_reference :masseur_details, :body_hair, index: true, foreign_key: true
    add_reference :masseur_details, :hair_color, index: true, foreign_key: true
    add_reference :masseur_details, :eye_color, index: true, foreign_key: true
    add_reference :masseur_details, :sexual_orientation, index: true, foreign_key: true
    add_reference :masseur_details, :smoking_frequency, index: true, foreign_key: true
    add_reference :masseur_details, :drug_frequency, index: true, foreign_key: true
    add_reference :masseur_details, :ethnicity, index: true, foreign_key: true
  end
end
