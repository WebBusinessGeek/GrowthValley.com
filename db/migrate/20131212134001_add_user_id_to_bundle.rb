class AddUserIdToBundle < ActiveRecord::Migration
  def change
   add_column :bundles , :user_id ,:integer
  end
end
