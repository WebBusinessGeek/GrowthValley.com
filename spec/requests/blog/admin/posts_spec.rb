# encoding: UTF-8
require 'spec_helper'
describe "posts" do
  context "logged in user" do
    before(:each) do
      blog_log_in
    end

    it "can access post's admin" do
      visit blog_admin_posts_path
      page.should have_content "Add A Post"
    end

    it "can create new post" do
      visit new_blog_admin_post_path
      page.should have_content "New Post"
      fill_in "Title", with:  "my title"
      fill_in "Content", with:  "C'est l'histoire d'un gars comprends tu...and finally it has some french accents àèùöûç...meh!"
      fill_in "Published at", with:  DateTime.now
      click_button "Save"
      page.should have_content "Post created"
    end

    it "will output error messages if error(s) there is" do
      visit new_blog_admin_post_path
      page.should have_content "New Post"
      click_button "Save"
      page.should have_content "Title can't be blank"
      page.should have_content "Content can't be blank"
      page.should have_content "Published at can't be blank"
    end

    it "can create a new post with tags removing the empty spaces" do
      visit new_blog_admin_post_path
      fill_in "Title", with:  "title"
      fill_in "Content", with:  "content"
      fill_in "Published at", with:  DateTime.now
      fill_in "Tags",with: "  rails, ruby,    one great tag"
      click_button "Save"
      page.should have_field :tag_list ,with: "rails, ruby, one great tag"
    end
  end

  context "NOT logged in user" do
    it "can NOT access post's admin" do
      visit blog_admin_posts_path
      page.should have_content "You must first log in"
    end

    it "can NOT create new post" do
      visit new_blog_admin_post_path
      page.should have_content "You must first log in"
    end

    it "can NOT edit posts" do
      post = Factory(:post)
      visit edit_blog_admin_post_path(post)
      page.should have_content "You must first log in"
    end
  end
end