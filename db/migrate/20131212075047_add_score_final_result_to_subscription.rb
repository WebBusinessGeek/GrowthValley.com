class AddScoreFinalResultToSubscription < ActiveRecord::Migration
  def change
  add_column :subscriptions , :score , :integer
  add_column :subscriptions , :final_result , :string
  end
end
