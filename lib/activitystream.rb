module Activitystream
	def add_activity_stream(modulename, moduleid, actionname)
		if modulename.to_s == 'COURSE'
			#coursedetail = Course.find_by_id(moduleid)
			coursedetail = moduleid
			if actionname.to_s == "published"
				notification_for = "Learner"
				message = "A new course named '<a href='"+course_path(coursedetail)+"'>"+coursedetail.title.capitalize+"</a>' has been published under "+coursedetail.subject.name.capitalize+"."
			end
			
			if actionname.to_s == "updated"
				notification_for = "Learner"
				message = "A new course named '<a href='"+course_path(coursedetail)+"'>"+coursedetail.title.capitalize+"</a>' has been published under "+coursedetail.subject.name.capitalize+"."
			end
			
			if actionname.to_s == "result"
				notification_for = "Learner"
				message = "Exam result has been announced for your course named '<a href='"+course_path(coursedetail)+"'>"+coursedetail.title.capitalize+"</a>'. <a href='"+course_path(coursedetail)+"'>Click Here</a> to view result."
			end
			
			if actionname.to_s == "subscribe"
				notification_for = "Teacher"
				message = "A new user has subsribed for your course '<a href='"+course_path(coursedetail)+"'>"+coursedetail.title.capitalize+"</a>'."
			end
			
			if actionname.to_s == "completed"
				notification_for = "Teacher"
				message = "A user has completed the exam for '<a href='"+course_path(coursedetail)+"'>"+coursedetail.title.capitalize+"</a>' course. Kindly review his exam."
			end
		end

		Notification.new(:module => modulename, :module_id => coursedetail.id, :notification_for => notification_for, :action => actionname.to_s, :user_id => current_user.id, :message => message).save
	end
	
	def get_activity_stream(no_of_records)
	  if current_user.type.to_s == "Teacher"
		  if no_of_records > 0
		    user_notifications = Notification.find(:all, :conditions => ["notification_for = 'Teacher' and module_id IN (?)", Course.where("subject_id IN (?)", current_user.subjects.map( &:id)).map( &:id)], :limit => no_of_records, :order=>"created_at desc")
		  else
		    user_notifications = Notification.find(:all, :conditions => ["notification_for = 'Teacher' and module_id IN (?)", Course.where("subject_id IN (?)", current_user.subjects.map( &:id)).map( &:id)], :order=>"created_at desc")
		  end
	  else #learner
      course_ids = Array.new
      current_user.teachers.each do |teacher|
        teacher.courses.each do |course|
          course_ids.push(course.id)
        end
      end

		  if no_of_records > 0
        user_notifications = Notification.find(:all, :conditions => ["notification_for = 'Learner' and ((module_id IN (?) and action = 'published') or (action = 'updated' and module_id IN (?)) or module_id IN (?))", Course.where("subject_id IN (?)", current_user.subjects.map( &:id)).map( &:id), current_user.subscriptions.map( &:course_id), course_ids], :limit => no_of_records, :order=>"created_at desc")
		  else
        user_notifications = Notification.find(:all, :conditions => ["notification_for = 'Learner' and ((module_id IN (?) and action = 'published') or (action = 'updated' and module_id IN (?)) or module_id IN (?))", Course.where("subject_id IN (?)", current_user.subjects.map( &:id)).map( &:id), current_user.subscriptions.map( &:course_id), course_ids], :order=>"created_at desc")
		  end
	  end
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
