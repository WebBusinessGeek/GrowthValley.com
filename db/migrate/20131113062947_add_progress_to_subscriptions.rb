class AddProgressToSubscriptions < ActiveRecord::Migration
  def up
    add_column :subscriptions, :progress, :string
  end

  def down
    drop_column :subscriptions, :progress
  end
end
