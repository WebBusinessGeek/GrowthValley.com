class Course < ActiveRecord::Base
  serialize :classroom_properties, ActiveRecord::Coders::Hstore
  attr_accessible :title, :course_cover_pic, :course_cover_pic_cache, :remove_course_cover_pic, :description, :is_published, :content_type,
  :sections_count, :status, :is_paid, :price, :subject_id, :sections_attributes, :ratings_attributes, :slug, :classroom_enabled

  alias_attribute :amount, :price
  alias_attribute :course_title, :title
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :classrooms, class_name: "Pl::Classroom"
  has_and_belongs_to_many :bundles
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  belongs_to :subject
  has_many :sections, dependent: :destroy
  has_one :exam, dependent: :destroy
  has_many :premium_courses, dependent: :destroy
  has_many :learners_exams, dependent: :destroy
  has_many :recommended_courses, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :transactions, as: :resource

  accepts_nested_attributes_for :users, :allow_destroy => true
  accepts_nested_attributes_for :subscriptions, :allow_destroy => true
  accepts_nested_attributes_for :sections, :allow_destroy => true
  accepts_nested_attributes_for :ratings, :allow_destroy => true
  accepts_nested_attributes_for :exam, :allow_destroy => true
  accepts_nested_attributes_for :recommended_courses, :allow_destroy => true
  accepts_nested_attributes_for :premium_courses, :allow_destroy => true
  accepts_nested_attributes_for :learners_exams, :allow_destroy => true

  #  has_many :charges, dependent: :destroy
  #  accepts_nested_attributes_for :charges, :allow_destroy => true

  mount_uploader :course_cover_pic, CourseCoverPicUploader

  CONTENT_TYPES = [ ['PDF', 'pdf'], ['Video', 'video'], ['Both', 'both'] ]

  validates :sections, :length => { minimum: 1, maximum: 5 }, if: :active_or_on_sections_step?
  validates :title, presence: true, uniqueness: true
#  validates :content_type, inclusion: { in: %w(pdf video both), message: "Invalid selection, allowed course types: #{%w(pdf video)}" }, if: :active_or_on_type_step?
  validate :sections_count_validation, if: :active_or_on_sections_count_step?
  validate :price, presence: true, numericality: true, if: :active_or_on_price_step?
  validates :subject, presence: true, if: :active_or_on_subject_step?

  scope :free_user_published_courses, ->(user_id) { includes(:users).where("users.id = ? and users.type = ? and users.subscription_type = ? and is_paid = ? and is_published = ?", user_id, 'Teacher', 'free', false, true) }
  scope :paid_user_free_published_courses, ->(user_id) { includes(:users).where("users.id = ? and users.type = ? and users.subscription_type = ? and is_paid = ? and is_published = ?", user_id, 'Teacher', 'paid', false, true) }
  scope :paid_user_paid_published_courses, ->(user_id) { includes(:users).where("users.id = ? and users.type = ? and users.subscription_type = ? and is_paid = ? and is_published = ?", user_id, 'Teacher', 'paid', true, true) }
  scope :all_published_courses_for_subjects, ->(subs) { where("(subject_id in (?)) and is_published = ?", subs.map(&:id), true) }
  scope :all_published, -> { where("is_published = ?", true) }
  scope :with_sections, -> { includes(:sections) }

  include PgSearch
  pg_search_scope :search, against: [:title, :description],
   using: {tsearch: {dictionary: "english"}}

  %w[minimum_price private_classroom].each do |key|
    attr_accessible key
    scope "has_#{key}", lambda { |value| where("classroom_properties @> hstore(?, ?)", key, value) }

    define_method(key) do
      classroom_properties && classroom_properties[key]
    end

    define_method("#{key}=") do |value|
      self.classroom_properties = (classroom_properties || {}).merge(key => value)
    end
  end

  def learner_names
    a = []
    classrooms.limit(5).collect {|x| a << {id: x.id, full_name: x.learner.full_name}}
    a
  end

  def self.text_search(params)
    if params[:search].present?
      search(params[:search])
    end
  end

  def togglePublish
    if self.is_published == false
      if eachSectionHasTest? && has_exam?
        self.update_attributes(is_published: true)
        return true
      else
        return { status: 'error', error_code: 1, error_msg: 'Error! Each section must have a test and course must have an exam...' }
      end
    else
      if has_active_learners?
        return { status: 'error', error_code: 2, error_msg: 'You cannot unpublish a course that has active subscription(s)!' }
      else
        self.update_attributes(is_published: false)
        return true
      end
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

  def has_active_learners?
    Subscription.where(course_id: self.id, user_type: 'Learner').present?
  end

  def avg_rating(courseId)
    Rating.where(course_id: courseId).average('rate').to_i
  end

  def sections_count_range
    arr = Array.new
    upper_limit = (5 - self.sections.count)

    if sections.count == 0 # new_record
      1.upto(upper_limit).each do |v|
        arr << [v, v]
      end
    else # existing sections
      0.upto(upper_limit).each do |v|
        arr << [v, v]
      end
    end

    return arr
  end

  def teacher
    users.where(:type => 'Teacher').first
  end

  private

  def active?
    status == :active
  end

  def active_or_on_price_step?
    status == :price || active?
  end

  def active_or_on_subject_step?
    status == :subject || active?
  end

#  def active_or_on_type_step?
#    status == :type || active?
#  end

  def active_or_on_sections_count_step?
    status == :sections_count || active?
  end

  def active_or_on_sections_step?
    status == :sections || active?
  end

  def sections_count_validation
    unless sections_count_range.flatten!.include?(sections_count.to_i)
      errors.add(:sections_count, 'is out of range.')
    end
  end
end
