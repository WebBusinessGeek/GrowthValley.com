class AddProgressPercentageToSubscription < ActiveRecord::Migration
  def up
    add_column :subscriptions, :progress_percentage, :integer, :default => 0
  end

  def down
    drop_column :subscriptions, :progress_percentage
  end
end
