class StaticPage < ActiveRecord::Base
  extend FriendlyId

  translates :title, :content, :slug

  friendly_id :title, use: [:slugged, :finders, :globalize]

  validates :content, presence: true

  globalize_accessors locales: ACTIVE_LOCALES.collect {|l| l[:code]}

  before_save :translate_slugs

  def translate_slugs
    StaticPage.globalize_attribute_names.reject { |loc| (loc.to_s.include?('slug') || loc.to_s.include?('_en') || loc.to_s.include?('content')) }.each do |attr|

      logger.debug "Setting slug_#{attr[-2, 2]} to #{self.send(attr)}!"
      self.set_friendly_id(self.send(attr), attr[-2, 2].to_sym)
    end

  end
end
