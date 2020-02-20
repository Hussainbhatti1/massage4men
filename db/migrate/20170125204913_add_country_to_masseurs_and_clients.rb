class AddCountryToMasseursAndClients < ActiveRecord::Migration
  def change
    add_column :clients, :country, :string, default: 'US'
    add_column :masseurs, :mailing_country, :string, default: 'US'
  end
end
