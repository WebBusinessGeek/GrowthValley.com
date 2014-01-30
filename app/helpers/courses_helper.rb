module CoursesHelper
  def format_learner_names(course)
    array = course.learner_names
    content_tag :ul do
      array.each do |learner|
        concat(content_tag :li, link_to(learner[:full_name], classroom_path(id: learner[:id])))
      end
    end.html_safe
  end
end
