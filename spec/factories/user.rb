FactoryGirl.define do
  factory :user, class: User do
    sequence(:full_name){|n| "test #{n}"}
    sequence(:email){ |n| "test#{n}@example.com"}
    password "password"
    password_confirmation "password"
    type "Teacher"
  end

  factory :teacher, parent: :user, class: Teacher do
    type "Teacher"
  end

  factory :learner, parent: :user, class: Learner do
    type "Learner"
  end

  factory :paid_learner, parent: :user, class: Learner do
    type "Learner"
    subscription_type "paid"
  end

  factory :paid_teacher, parent: :user, class: Teacher do
    type "Teacher"
    subscription_type "paid"
  end

  factory :free_learner, parent: :user, class: Learner do
    type "Learner"
    subscription_type "free"
  end

  factory :free_teacher, parent: :user, class: Teacher do
    type "Teacher"
    subscription_type "free"
  end
end