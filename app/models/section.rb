class Section < ActiveRecord::Base
  attr_accessible :description, :title, :attachment, :attachment_cache, :remove_attachment

  belongs_to :course

  mount_uploader :attachment, AttachmentUploader

  validates :attachment, presence: true
  validates_associated :course
end
