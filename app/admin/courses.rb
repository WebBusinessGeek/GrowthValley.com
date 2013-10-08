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
end
