class Pl::AttachmentTeachable < ActiveRecord::Base
  attr_accessible :asset, :content

  has_one :content, as: :teachable

  mount_uploader :asset, AttachmentUploader
end
