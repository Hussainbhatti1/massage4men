class MasseurLanguage < ActiveRecord::Base
  belongs_to :masseur
  belongs_to :language
end
