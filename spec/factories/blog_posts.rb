FactoryGirl.define do
  factory :post, class: Blog::Post do
    published true
    association :user
    sequence(:title) {|i| "post title #{i}"}
    content "A sample of text for this post that has some html markup"
    sequence(:url) { |i| "url#{i}" }
    sequence(:published_at)  {|i| DateTime.new(2013,1,1,12,0,0) + i.days }
  end

  factory :unpublished_post, class: Blog::Post, parent: :post do |post|
    published false
    title "unpublished"
    url "unpublished"
  end

  factory :post_with_tags, class: Blog::Post, parent: :post do |post|
    post.after_create { |p| p.tag!(['Rails', 'a great tag', 'Tech'])}
  end
end