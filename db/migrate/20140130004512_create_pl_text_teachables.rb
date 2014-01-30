class CreatePlTextTeachables < ActiveRecord::Migration
  def change
    create_table :pl_text_teachables do |t|
      t.text :content

      t.timestamps
    end
  end
end
