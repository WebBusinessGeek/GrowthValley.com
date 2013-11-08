class Subject < ActiveRecord::Base
  attr_accessible :name, :slug
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :users
  validates_associated :users

  has_and_belongs_to_many :courses
  validates_associated :courses
end
