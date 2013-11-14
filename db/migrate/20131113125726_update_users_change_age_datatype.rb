class UpdateUsersChangeAgeDatatype < ActiveRecord::Migration
  def up
    remove_column :users, :age
    add_column :users, :date_of_birth, :date
  end

  def down
    remove_column :users, :date_of_birth
    add_column :users, :age, :integer
  end
end
