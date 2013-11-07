ActiveAdmin.register Course do
  filter :title
  filter :content_type, :as => :select, :collection => ['video','pdf']
  filter :is_paid
  
	scope :all, :default => true

	scope :published do |courses|
	  courses.where("is_published = true")
	end

	scope :un_published do |courses|
	  courses.where("is_published = false")
	end
	
  index do
    column :title
    column :content_type
    column :status
    column :is_published
    column :is_paid
	actions :defaults => true
  end

  show do
    panel "Course Details"  do
      attributes_table_for course do
		row :title
		row :description
		row("Cover Pic") { |p|
          image_tag p.course_cover_pic_url()
        }
		row("Teacher") { |p|
          link_to(p.users.find_by_type("Teacher").email, admin_user_url(p.users.find_by_type("Teacher")))
        }
		row :content_type
		row :status
		row :is_published
		row :is_paid
		row :sections_count
		row :created_at
		row :updated_at
      end

      panel "Sections" do
        table_for course.sections do
          column("Title") {|p| p.title }
          column("Attachment") {|p| link_to "View", p.attachment_url() }
        end
      end
    end
  end
  
  sidebar "Course Subscribers", :only => :show do
    table_for course.users.find_all_by_type("Learner") do |t|
      t.column("") { |p| link_to(p.email, admin_user_url(p))}
    end
  end
  
  
end
