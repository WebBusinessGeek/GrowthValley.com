module Blog
  class Tag < ActiveRecord::Base
    include ActiveModel::ForbiddenAttributesProtection
    has_many :taggings
    has_many :posts, through: :taggings

    validates :name, uniqueness: true,presence: true
  end
end
