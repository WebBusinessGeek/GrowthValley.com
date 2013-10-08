ActiveAdmin.register User do
  filter :email
  filter :full_name
  filter :subscription_type, :as => :select, :collection => ['free','paid']
  filter :subjects_id, collection: proc { Subject.all }, as: :check_boxes
  
	scope :all, :default => true

	scope :teachers do |users|
	  users.where("type = 'Teacher'")
	end

	scope :learners do |users|
	  users.where("type = 'Learner'")
	end
	
  index do
    column :email
    column :subscription_type
    column :type
	actions :defaults => false do |user|
  		link_to("Details" , admin_user_url(user))
    end
  end

  show do
    attributes_table do
		row :email
		row :description
		row :type
		row :subscription_type
		row :sign_in_count
		row :last_sign_in_at
		row :created_at
		row :updated_at
	end
  end
end
