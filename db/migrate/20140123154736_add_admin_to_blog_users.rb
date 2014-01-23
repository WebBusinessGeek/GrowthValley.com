class AddAdminToBlogUsers < ActiveRecord::Migration
  def change
    add_column :blog_users, :admin, :boolean, default: false
  end
end
