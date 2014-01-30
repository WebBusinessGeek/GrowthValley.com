class Pl::Task < ActiveRecord::Base
  attr_accessible :checklist_id, :completed, :content

  belongs_to :checklist, class_name: 'Pl::ChecklistTeachable', foreign_key: 'checklist_id'
end
