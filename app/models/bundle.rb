class Bundle < ActiveRecord::Base
  attr_accessible :bundle_pic, :name, :price ,:course_ids
  has_and_belongs_to_many :courses
  belongs_to :user
  mount_uploader :bundle_pic, BundlePicUploader
end
