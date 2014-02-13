class AddPaidToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :paid, :boolean, default: false
  end
end
