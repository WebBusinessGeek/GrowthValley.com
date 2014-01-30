class Pl::TextTeachable < ActiveRecord::Base
  attr_accessible :content

  has_one :content, as: :teachable
end
