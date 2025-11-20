class CreateActivityLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action, null: false
      t.string :resource_type
      t.integer :resource_id
      t.text :description
      t.string :ip_address
      t.text :user_agent
      t.datetime :performed_at, null: false

      t.timestamps
    end
    
    add_index :activity_logs, [:user_id, :performed_at]
    add_index :activity_logs, [:resource_type, :resource_id]
    add_index :activity_logs, :performed_at
  end
end
