FactoryGirl.define do
  factory :classroom, class: Pl::Classroom do
    privacy false
    association :course, factory: :course
    sequence(:title) {|i| "classroom title #{i}"}
    description "A sample of text for this post that has some html markup"
    state 'requested'
  end

  factory :classroom_with_users, parent: :classroom, class: Pl::Classroom do |classroom|
    classroom.after_create do |c|
      c.users << FactoryGirl.build(:teacher)
      c.users << FactoryGirl.build(:learner)
    end
  end
end