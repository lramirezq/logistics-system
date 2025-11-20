class AddLocationToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :country, :string
    add_column :companies, :region, :string
    add_column :companies, :province, :string
    add_column :companies, :commune, :string
  end
end
