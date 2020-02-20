class AddFriendlyIdGlobalizeSupportToStaticPages < ActiveRecord::Migration
  def change
    add_column :static_pages, :slug, :string
  end  
end
