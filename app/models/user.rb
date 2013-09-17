class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :full_name, :description, :type, :subject_ids

  has_and_belongs_to_many :subjects

  validates_presence_of :type
  validates :subjects, :presence => true, :length => { :maximum => 3 }, :if => "type.present?"

  accepts_nested_attributes_for :subjects, :limit => 3

  USER_ROLES = [
    ['Im here to learn', 'Learner'],
    ['Im here to teach a skill', 'Teacher']
  ]
end
