class AddClassroomIdToClassroomRequests < ActiveRecord::Migration
  def change
    add_column :pl_classroom_requests, :classroom_id, :integer
    add_column :pl_classroom_requests, :escrow, :boolean
    add_index :pl_classroom_requests, :classroom_id
  end
end
