class Section < ActiveRecord::Base
  attr_accessible :description, :title, :attachment, :attachment_cache, :remove_attachment

  belongs_to :course
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions

  validates :attachment, presence: true
  validates_associated :course
  validates :questions, :length => { minimum: 3, maximum: 10 }, allow_blank: true

  accepts_nested_attributes_for :questions, :allow_destroy => true, limit: 10
  accepts_nested_attributes_for :answers, :allow_destroy => true

  mount_uploader :attachment, AttachmentUploader

  def complete?
    if self.questions.present? && self.answers.present?
      return true
    else
      return false
    end
  end
end
