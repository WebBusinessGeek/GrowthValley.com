class CreateBundlesUsersJoinTable < ActiveRecord::Migration
  def change
    create_table 'bundles_users', :id => false do |t|
      t.references :bundle
      t.references :user
    end
  end
end
