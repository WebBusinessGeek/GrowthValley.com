class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :full_name, :description, :type, :age, :sex, :subscription_type, :subject_ids, :course_ids

  has_and_belongs_to_many :subjects
  before_destroy { subjects.clear }

  has_and_belongs_to_many :courses
  before_destroy { courses.clear }

  validates_presence_of :type, on: :create
  validates :subjects, :presence => true, :length => { :maximum => 3 }, :if => "type.present?", on: :create

  accepts_nested_attributes_for :subjects, :allow_destroy => true, :limit => 3
  accepts_nested_attributes_for :courses, :allow_destroy => true

  USER_ROLES = [
    ['Im here to learn', 'Learner'],
    ['Im here to teach a skill', 'Teacher']
  ]
end
