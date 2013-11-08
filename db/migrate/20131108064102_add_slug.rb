class AddSlug < ActiveRecord::Migration
  def up
    add_column :subjects, :slug, :string
    add_column :courses, :slug, :string
    add_column :sections, :slug, :string
  end

  def down
  end
end
