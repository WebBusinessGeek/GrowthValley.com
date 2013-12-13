class CreateBundles < ActiveRecord::Migration
  def change
    create_table :bundles do |t|
      t.string :name
      t.float :price
      t.string :bundle_pic

      t.timestamps
    end
  end
end
