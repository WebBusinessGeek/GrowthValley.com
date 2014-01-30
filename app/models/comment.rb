class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_id, :commentable_type, :user_id

  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
