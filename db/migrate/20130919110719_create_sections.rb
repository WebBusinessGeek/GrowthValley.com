class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.text :description
      t.string :attachment
      t.references :course

      t.timestamps
    end
  end
end
