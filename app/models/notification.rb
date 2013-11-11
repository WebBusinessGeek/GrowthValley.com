class Notification < ActiveRecord::Base
	attr_accessible :module, :action, :module_id, :user_id, :message, :notification_for
	after_save :get_new_id
	cattr_accessor :NEWID
	def get_new_id
		self.NEWID = self.id
	end

	belongs_to :user
end
