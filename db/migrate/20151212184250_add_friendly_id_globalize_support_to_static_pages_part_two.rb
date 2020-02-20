class AddFriendlyIdGlobalizeSupportToStaticPagesPartTwo < ActiveRecord::Migration
  def up
    StaticPage.add_translation_fields! slug: :string
  end
  
  def down
    remove_column :static_page_translations, :slug
  end
end
