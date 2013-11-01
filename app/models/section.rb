class Section < ActiveRecord::Base
  attr_accessible :title, :description, :unlocked, :course_id, :attachment, :attachment_cache, :remove_attachment, :quizzes_attributes

  belongs_to :course
  validates_associated :course

  has_many :quizzes, dependent: :destroy
  validates :quizzes, :length => { minimum: 3, maximum: 10 }, allow_blank: true
  accepts_nested_attributes_for :quizzes, :allow_destroy => true, limit: 10

  mount_uploader :attachment, AttachmentUploader

  default_scope { order("id asc") }

  def complete?
    if self.quizzes.present?
      return true
    else
      return false
    end
  end
end
