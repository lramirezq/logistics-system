class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :company_type, null: false
      t.string :tax_id
      t.text :address
      t.string :phone
      t.string :email
      t.integer :parent_id
      t.boolean :active, default: true

      t.timestamps
    end
    
    add_index :companies, :parent_id
    add_index :companies, :company_type
  end
end
