module Blog
  class User < ActiveRecord::Base
    self.table_name = "blog_users"
    include ActiveModel::ForbiddenAttributesProtection
    has_many :posts, dependent: :destroy

    has_secure_password

    validates_presence_of :password, on: :create
    validates_presence_of :name
    validates :email , presence: true, uniqueness: true

    def can_delete?(user)
      return false if !self.admin?
      return false if self == user
      true
    end
  end
end
