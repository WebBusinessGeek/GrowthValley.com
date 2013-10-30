class Course < ActiveRecord::Base
  attr_accessible :title, :course_cover_pic, :course_cover_pic_cache, :remove_course_cover_pic, :description, :is_published, :content_type, 
  :sections_count, :status, :is_paid, :price, :subject_ids, :sections_attributes, :ratings_attributes

  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users, :allow_destroy => true

  has_and_belongs_to_many :subjects
  before_destroy { subjects.clear }
  accepts_nested_attributes_for :subjects, :allow_destroy => true
  validates :subjects, presence: true, if: :active_or_on_subjects_step?

  has_many :sections, dependent: :destroy
  accepts_nested_attributes_for :sections, :allow_destroy => true
  validates :sections, :length => { minimum: 1, maximum: 5 }, if: :active_or_on_sections_step?

  has_one :exam, dependent: :destroy
  accepts_nested_attributes_for :exam, :allow_destroy => true

  has_many :ratings, dependent: :destroy
  accepts_nested_attributes_for :ratings, :allow_destroy => true

  has_many :charges, dependent: :destroy
  accepts_nested_attributes_for :charges, :allow_destroy => true

  mount_uploader :course_cover_pic, CourseCoverPicUploader

  CONTENT_TYPES = [ ['PDF', 'pdf'], ['Video', 'video'] ]

  validates :title, presence: true, uniqueness: true
  validates :content_type, inclusion: { in: %w(pdf video), message: "Invalid selection, allowed course types: #{%w(pdf video)}" }, if: :active_or_on_type_step?
  validate :sections_count_range, if: :active_or_on_sections_count_step?
  validate :price, presence: true, numericality: true, if: :active_or_on_price_step?

  scope :free_user_published_courses, ->(user_id) { includes(:users).where("users.id = ? and users.type = ? and users.subscription_type = ? and is_paid = ? and is_published = ?", user_id, 'Teacher', 'free', false, true) }
  scope :paid_user_free_published_courses, ->(user_id) { includes(:users).where("users.id = ? and users.type = ? and users.subscription_type = ? and is_paid = ? and is_published = ?", user_id, 'Teacher', 'paid', false, true) }
  scope :paid_user_paid_published_courses, ->(user_id) { includes(:users).where("users.id = ? and users.type = ? and users.subscription_type = ? and is_paid = ? and is_published = ?", user_id, 'Teacher', 'paid', true, true) }
  scope :all_published_courses_for_subjects, ->(subs) { includes(:subjects).where("(subjects.id = ? or subjects.id = ? or subjects.id = ?) and is_published = ?", subs.map(&:id)[0], subs.map(&:id)[1], subs.map(&:id)[2], true) }
  scope :all_published, -> { where("is_published = ?", true) }

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

  def has_exam?
    (self.exam.present? && self.exam.exam_questions.present?) ? true : false
  end

  def isCourseLive?
    if self.is_published == true && eachSectionHasTest?
      return true
    else
      return false
    end
  end

  def avg_rating(courseId)
    Rating.where(course_id: courseId).average('rate').to_i
  end

  private

  def active?
    status == :active
  end

  def active_or_on_price_step?
    status == :price || active?
  end

  def active_or_on_subjects_step?
    status == :subjects || active?
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
