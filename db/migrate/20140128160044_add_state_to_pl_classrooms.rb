class AddStateToPlClassrooms < ActiveRecord::Migration
  def change
    add_column :pl_classrooms, :state, :string, index: true
  end
end
