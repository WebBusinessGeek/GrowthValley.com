module Activitystream
	def add_activity_stream(modulename, moduleid, actionname)
		
		if modulename.to_s == 'COURSE'
			#coursedetail = Course.find_by_id(moduleid)
			coursedetail = moduleid
			if actionname.to_s == "published"
				notification_for = "Learner"
				message = "A new course named '<a href='"+course_path(coursedetail)+"'>"+coursedetail.title.capitalize+"</a>' has been published under "+coursedetail.subject.name.capitalize+"."
			end
			
			if actionname.to_s == "subscribe"
				notification_for = "Teacher"
				message = "A new user has subsribed for your course '<a href='"+course_path(coursedetail)+"'>"+coursedetail.title.capitalize+"</a>."
			end
		end

		Notification.new(:module => modulename, :module_id => coursedetail.id, :notification_for => notification_for, :action => actionname.to_s, :user_id => current_user.id, :message => message).save
	end
	
	def get_activity_stream(no_of_records = 10)
		user_notifications = Notification.find(:all, :conditions => ["notification_for = ? and module_id IN (?)", current_user.type, Course.where("subject_id IN (?)", current_user.subjects.map( &:id)).map( &:id)], :limit => no_of_records)
	end


	def encode_ajax_string(string)
		encodedstring = ""
		encodedstring = string.gsub(/[']/, '***$1$###')
		encodedstring = encodedstring.gsub(/["]/, '***$2$###')
		encodedstring = encodedstring.gsub('&', '***$3$###')
		encodedstring = encodedstring.gsub('<', '***$4$###')
		encodedstring = encodedstring.gsub('>', '***$5$###')

		return encodedstring
	end

	def decode_ajax_string(string)
		decodedstring = ""
		decodedstring = string.gsub("***$1$###", "''")
		decodedstring = decodedstring.gsub('***$2$###', '"')
		decodedstring = decodedstring.gsub('***$3$###', '&')
		decodedstring = decodedstring.gsub('***$4$###', '<')
		decodedstring = decodedstring.gsub('***$5$###', '>')
		return decodedstring
	end	
end
