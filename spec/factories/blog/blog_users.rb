FactoryGirl.define do
  factory :blog_user, class: Blog::User do
    sequence(:name){|n| "test #{n}"}
    sequence(:email){ |n| "test#{n}@example.com"}
    password "password"
    password_confirmation "password"
  end

  factory :user_with_post, class: Blog::User, parent: :blog_user do |user|
    user.after_create { |u| Factory(:post, user: u) }
  end
end