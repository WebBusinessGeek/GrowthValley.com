class RemoveUserIdFromBundles < ActiveRecord::Migration
  def up
    remove_column :bundles, :user_id
  end

  def down
    add_column :bundles, :user_id, :integer
  end
end
