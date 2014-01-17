module Blog
  class Tag < ActiveRecord::Base
    has_many :taggings
    has_many :posts, through: :taggings

    validates :name, uniqueness: true,presence: true

    attr_accessible :name
  end
end
