FactoryGirl.define do
  factory :course, class: Course do
    title "Rails Test Course"
    description "Learn to build a website in Rails"
    content_type 'both'
    status 'active'
    is_published false
    is_paid false
    price 1
    slug 'rails-test-course'
    classroom_enabled false
    association :subject
  end

  factory :paid_course, parent: :course do
    is_published true
    is_paid true
  end
end