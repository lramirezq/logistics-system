class CreateCompanyRelationships < ActiveRecord::Migration[8.0]
  def change
    create_table :company_relationships do |t|
      t.references :client, null: false, foreign_key: { to_table: :companies }
      t.references :related_company, null: false, foreign_key: { to_table: :companies }
      t.string :relationship_type, null: false

      t.timestamps
    end
    
    add_index :company_relationships, [:client_id, :related_company_id, :relationship_type], 
              unique: true, name: 'idx_company_relationships_unique'
  end
end
