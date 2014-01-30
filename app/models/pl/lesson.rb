class Pl::Lesson < ActiveRecord::Base
  attr_accessible :completed, :description, :position, :title

  belongs_to :classroom
  has_many :contents, dependent: :destroy
end
