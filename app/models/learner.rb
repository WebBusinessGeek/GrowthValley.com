class Learner < User
  has_and_belongs_to_many :teachers

  def teacher_subscribed?(teacher)
    teachers.include?(teacher)
  end

  def subscribe_teacher(teacher)
    unless teacher_subscribed?(teacher)
      teachers.push(teacher)
    end
  end
end
