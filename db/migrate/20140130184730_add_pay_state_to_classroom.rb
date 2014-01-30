class AddPayStateToClassroom < ActiveRecord::Migration
  def change
    add_column :pl_classrooms, :pay_state, :string
  end
end
