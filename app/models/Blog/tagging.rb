module Blog
  class Tagging < ActiveRecord::Base
    include ActiveModel::ForbiddenAttributesProtection
    belongs_to :post
    belongs_to :tag
  end
end