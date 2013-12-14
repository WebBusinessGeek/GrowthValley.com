class Learner < User
  has_and_belongs_to_many :teachers

  def teacher_subscribed?(teacher_id_or_slug)
    teacher = find_teacher(teacher_id_or_slug)
    teachers.include?(teacher)
  end

  def subscribe_teacher(teacher_id_or_slug)
    teacher = find_teacher(teacher_id_or_slug)
    unless teacher_subscribed?(teacher)
      teachers.push(teacher)
    end
  end

  private

  def find_teacher(teacher_id_or_slug)
    Teacher.find(teacher_id_or_slug)
  end
end
