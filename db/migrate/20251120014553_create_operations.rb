class CreateOperations < ActiveRecord::Migration[8.0]
  def change
    create_table :operations do |t|
      t.integer :numero_operacion
      t.string :tipo_operacion
      t.date :fecha
      t.references :shipper, null: true, foreign_key: { to_table: :companies }
      t.references :consignatario, null: true, foreign_key: { to_table: :companies }
      t.references :ref_cliente, null: true, foreign_key: { to_table: :companies }
      t.string :emisor_master
      t.string :vessel_vuelo
      t.date :etd
      t.date :eta
      t.string :origen
      t.string :destino
      t.references :agente, null: true, foreign_key: { to_table: :companies }
      t.references :compania, null: true, foreign_key: { to_table: :companies }
      t.string :naviera
      t.string :numero_contenedor
      t.decimal :volumen, precision: 10, scale: 2
      t.decimal :peso, precision: 10, scale: 2
      t.string :bl_master
      t.string :bl_hijo
      t.decimal :fact_afecta, precision: 12, scale: 2
      t.decimal :fact_exenta, precision: 12, scale: 2
      t.decimal :fact_extranj, precision: 12, scale: 2
      t.decimal :compra_afecta, precision: 12, scale: 2
      t.decimal :compra_exenta, precision: 12, scale: 2
      t.text :observaciones

      t.timestamps
    end
    
    add_index :operations, :numero_operacion, unique: true
    add_index :operations, :fecha
    add_index :operations, :tipo_operacion
  end
end
