class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.text :description
      t.string :attachment
      t.boolean :unlocked, default: false
      t.references :course

      t.timestamps
    end
  end
end
