FactoryGirl.define do
  factory :classroom, class: Pl::Classroom do
    privacy false
    association :course, factory: :course
    sequence(:title) {|i| "classroom title #{i}"}
    description "A sample of text for this post that has some html markup"
    state 'requested'
  end
end