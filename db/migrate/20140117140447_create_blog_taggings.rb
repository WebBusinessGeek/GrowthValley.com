class CreateBlogTaggings < ActiveRecord::Migration
  def change
    create_table :blog_taggings do |t|
      t.integer :post_id, :tag_id
    end

    add_index :blog_taggings, :post_id
    add_index :blog_taggings, :tag_id
  end
end
