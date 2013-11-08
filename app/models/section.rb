class Section < ActiveRecord::Base
  attr_accessible :title, :description, :unlocked, :course_id, :attachment, :attachment_cache, :remove_attachment,
  :quizzes_attributes, :slug
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :course
  validates_associated :course

  has_many :quizzes, dependent: :destroy
  validates :quizzes, :length => { minimum: 3, maximum: 10 }, allow_blank: true
  accepts_nested_attributes_for :quizzes, :allow_destroy => true, limit: 10

  has_many :learners_quizzes, dependent: :destroy
  accepts_nested_attributes_for :learners_quizzes, :allow_destroy => true

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
