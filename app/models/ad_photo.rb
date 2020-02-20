class AdPhoto < ActiveRecord::Base
  # Associations
  belongs_to :ad
  belongs_to :travel_ad
  belongs_to :photo
  
  # Instance Methods
  # Override this method so it returns a travel ad if necessary
  def ad_obj
    ad ? ad : travel_ad
  end
  
  def set_primary
    self.update_attributes(primary: true)
  end
  
  def unset_primary
    self.update_attributes(primary: false)
  end
end
