class Bundle < ActiveRecord::Base
  attr_accessible :bundle_pic, :name, :price, :course_ids, :active, :available

  has_and_belongs_to_many :courses
  belongs_to :user

  mount_uploader :bundle_pic, BundlePicUploader

  scope :active_and_available_bundles, -> { where("active = ? and available = ?", true, true) }
  scope :active_bundles, -> { where("active = ?", true) }

  def activate
    update_attributes(:active => true, :available => true)
  end
end
