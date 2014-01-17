class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.string :url
      t.integer :user_id
      t.datetime :published_at
      t.boolean :published
      t.timestamps
    end

    add_index :blog_posts, :id, unique: true
    add_index :blog_posts, :published_at
    add_index :blog_posts, :user_id
  end
end
