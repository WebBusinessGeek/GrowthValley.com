class Pl::Content < ActiveRecord::Base
  attr_accessible :title, :teachable_attributes, :teachable_type

  TEACHABLE_TYPES = %w(
    Pl::AttachmentTeachable
    Pl::ChecklistTeachable
    Pl::TextTeachable
  ).freeze

  validates :teachable, associated: true
  validates :teachable_type, inclusion: TEACHABLE_TYPES
  validates :title, presence: true

  belongs_to :teachable, polymorphic: true, dependent: :destroy
  belongs_to :lesson

  accepts_nested_attributes_for :teachable

  def build_teachable(type, attributes)
    teachable_class = type.constantize
    self.teachable = teachable_class.new(attributes.merge(content: self))
  end
end
