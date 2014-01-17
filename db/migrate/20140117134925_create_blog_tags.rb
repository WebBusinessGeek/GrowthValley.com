class CreateBlogTags < ActiveRecord::Migration
  def change
    create_table :blog_tags do |t|
      t.string :name
      t.timestamps
    end

    add_index :blog_tags, :name
  end
end
