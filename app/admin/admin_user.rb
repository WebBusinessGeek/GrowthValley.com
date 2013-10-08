ActiveAdmin.register AdminUser do 
  menu false
  
  controller do
	def index
		redirect_to admin_change_password_url()
	end
	def show
		redirect_to admin_change_password_url()
	end
	def new
		redirect_to admin_change_password_url()
	end
    def edit
		if !params[:id].present?
			@admin_user = AdminUser.find_by_id(current_admin_user.id)
		end
		super
		@page_title="My Custom New"
	end
  end
  
  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Change Password" do                
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions do
		f.action :submit, :label => "Update Password"
	end                        
  end                        
end                                   
