class CreatePlAttachmentTeachables < ActiveRecord::Migration
  def change
    create_table :pl_attachment_teachables do |t|
      t.string :asset

      t.timestamps
    end
  end
end
