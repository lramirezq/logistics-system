class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :position
      t.string :phone
      t.string :email
      t.references :company, null: false, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
