require 'spec_helper'

describe Blog::Admin::PostsController do
  let(:user) { create(:user) }
  before do
    sign_in_as user
  end

  describe 'PUT #update' do
    let(:post) { create(:post) }
    let(:new_content) { 'This is the new content, for real!' }
    let(:new_title) { 'nothing to do, I find it awesome!' }

    context :valid do
      before do
        put :update,
          id: post.id,
          blog_post: {
            content: new_content,
            title: new_title,
            published: false
          }
        post.reload
      end

      it { expect(post.content).to eq new_content }
      it { expect(post.title).to eq new_title }
      it { expect(post.published).to be_false }
    end
  end
end