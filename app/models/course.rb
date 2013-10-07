class Course < ActiveRecord::Base
  attr_accessible :title, :course_cover_pic, :course_cover_pic_cache, :remove_course_cover_pic, :description, :is_published, :content_type, 
  :sections_count, :status, :is_paid, :subject_ids, :sections_attributes

  has_and_belongs_to_many :users

  has_and_belongs_to_many :subjects
  before_destroy { subjects.clear }

  has_many :sections, dependent: :destroy
  validates :sections, :length => { minimum: 1, maximum: 5 }, if: :active_or_on_sections_step?

  accepts_nested_attributes_for :users, :allow_destroy => true
  accepts_nested_attributes_for :subjects, :allow_destroy => true
  accepts_nested_attributes_for :sections, :allow_destroy => true

  mount_uploader :course_cover_pic, CourseCoverPicUploader

  CONTENT_TYPES = [ ['PDF', 'pdf'], ['Video', 'video'] ]

  validates :title, presence: true, uniqueness: true
  validates :content_type, inclusion: { in: %w(pdf video), message: "Invalid selection, allowed course types: #{%w(pdf video)}" }, if: :active_or_on_type_step?
  validate :sections_count_range, if: :active_or_on_sections_count_step?

  scope :free_user_published_courses, ->(user_id) { includes(:users).where("users.id = ? and users.type = ? and users.subscription_type = ? and is_paid = ? and is_published = ?", user_id, 'Teacher', 'free', false, true) }
  scope :paid_user_free_published_courses, ->(user_id) { includes(:users).where("users.id = ? and users.type = ? and users.subscription_type = ? and is_paid = ? and is_published = ?", user_id, 'Teacher', 'paid', false, true) }
  scope :paid_user_paid_published_courses, ->(user_id) { includes(:users).where("users.id = ? and users.type = ? and users.subscription_type = ? and is_paid = ? and is_published = ?", user_id, 'Teacher', 'paid', true, true) }

  def togglePublish
    if self.is_published == false
      if eachSectionHasTest?
        self.update_attributes(is_published: true)
      else
        return false
      end
      return true
    else
      self.update_attributes(is_published: false)
      return true
    end
  end

  def eachSectionHasTest?
    if self.sections.present?
      self.sections.each do |section|
        if section.complete? == false
          return false
        end
      end
      return true
    else
      return false
    end
  end

  def isCourseLive?
    if self.is_published == true && eachSectionHasTest?
      return true
    else
      return false
    end
  end

  private

  def active?
    status == :active
  end

  def active_or_on_type_step?
    status == :type || active?
  end

  def active_or_on_sections_count_step?
    status == :sections_count || active?
  end

  def active_or_on_sections_step?
    status == :sections || active?
  end

  def sections_count_range
    upper_limit = (5 - self.sections.count)
    if self.sections_count < 1 || self.sections_count > upper_limit
      self.errors.add(:sections_count, "Invalid range. Valid range is between #{1..upper_limit}")
    end
  end
end
