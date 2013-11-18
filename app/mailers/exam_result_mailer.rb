class ExamResultMailer < ActionMailer::Base
  default from: "no-reply@growthvalley.com"

  def send_message(teacher_id, student_id, learners_exams, recommended_courses = nil)
    @teacher = User.find_by_id(teacher_id)
    learner = User.find_by_id(student_id)

    sender = "#{@teacher.full_name} <#{@teacher.email}>" if @teacher.present?
    recepient = "#{learner.full_name} <#{learner.email}>" if learner.present?

    @learners_exams = learners_exams
    @recommended_courses = recommended_courses

    mail(:from => sender, :to => recepient, :subject => "Exam result released") do |format|
      format.html
    end
  end
end
