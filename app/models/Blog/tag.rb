module Blog
  class Tag < ActiveRecord::Base
    self.table_name = "blog_tags"
    include ActiveModel::ForbiddenAttributesProtection
    has_many :taggings
    has_many :posts, through: :taggings

    validates :name, uniqueness: true, presence: true

    def posts_with_tag
      self.posts.published
    end

    def frequency
      posts_with_tag.size
    end
  end
end
