class CreateUsersSubjectsJoinTable < ActiveRecord::Migration
  def change
    create_table 'subjects_users', :id => false do |t|
      t.references :user
      t.references :subject
    end
  end
end
