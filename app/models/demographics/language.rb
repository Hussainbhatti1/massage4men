class Language < ActiveRecord::Base
  has_and_belongs_to_many :masseurs
  
  has_many :masseur_languages
  has_many :masseurs, through: :masseur_languages
  
  def english_and_native_name
    # Only return both for non-Latin alphabet languages
    # TODO: Fix this for ñ, ç, etc.
    corrected_native_name = self.native_name.gsub(/[ñçé]/, '')
    
    if self.native_name && (corrected_native_name.length < corrected_native_name.bytes.count)
     "#{self.english_name} (#{self.native_name})" 
    else
      english_name
    end
  end
end
