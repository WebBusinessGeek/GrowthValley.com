class Course < ActiveRecord::Base
  attr_accessible :title, :description, :is_published, :content_type, :sections_count, :subject_ids, :sections_attributes

  has_and_belongs_to_many :users

  has_and_belongs_to_many :subjects
  before_destroy { subjects.clear }

  has_many :sections, dependent: :destroy
  validates :sections, :length => { maximum: 5 }, allow_blank: true

  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :subjects
  accepts_nested_attributes_for :sections, limit: 5

  CONTENT_TYPES = [ ['PDF', 'pdf'], ['Video', 'video'] ]

  validates :title, uniqueness: true
  validates :content_type, inclusion: { in: %w(pdf video), message: "Invalid selection, allowed course types: #{%w(pdf video)}" }, allow_blank: true
  validates :sections_count, inclusion: { in: 0..5 }, allow_blank: true
end
