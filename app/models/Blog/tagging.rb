module Blog
  class Tagging < ActiveRecord::Base
    self.table_name = "blog_taggings"
    include ActiveModel::ForbiddenAttributesProtection
    belongs_to :post
    belongs_to :tag
  end
end