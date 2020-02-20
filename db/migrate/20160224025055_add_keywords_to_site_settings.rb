class AddKeywordsToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :keywords, :text
  end
end
