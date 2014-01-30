class Pl::ChecklistTeachable < ActiveRecord::Base
  attr_accessible :tasks_attributes, :content
  has_one :content, as: :teachable
  has_many :tasks, foreign_key: 'checklist_id', dependent: :destroy

  accepts_nested_attributes_for :tasks, allow_destroy: true
end
