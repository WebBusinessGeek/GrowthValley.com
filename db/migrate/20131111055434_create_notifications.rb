class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification_for, :limit=>100
      t.string :module, :limit=>25
      t.integer :module_id
      t.string :action, :limit=>50
      t.integer :user_id
      t.text :message
      t.timestamps
    end
  end
end
