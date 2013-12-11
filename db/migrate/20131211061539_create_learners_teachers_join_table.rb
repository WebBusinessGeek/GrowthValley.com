class CreateLearnersTeachersJoinTable < ActiveRecord::Migration
  def up
    create_table 'learners_teachers', :id => false do |t|
      t.references :learner
      t.references :teacher
    end
  end

  def down
    drop_table 'learners_teachers'
  end
end
