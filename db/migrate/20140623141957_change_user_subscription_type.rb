class ChangeUserSubscriptionType < ActiveRecord::Migration
  def up
  	change_column :users, :subscription_type, :string, default: 'paid'
  end

  def down
  	change_column :users, :subscription_type, :string, default: 'free'
  end
end
