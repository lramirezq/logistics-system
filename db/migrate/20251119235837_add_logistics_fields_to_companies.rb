class AddLogisticsFieldsToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :codigo, :string
    add_column :companies, :razon_social, :string
    add_column :companies, :nombre_comercial, :string
    add_column :companies, :tipo_empresa, :string, null: false, default: 'COMPANIA'
    
    add_index :companies, :codigo, unique: true
  end
end
