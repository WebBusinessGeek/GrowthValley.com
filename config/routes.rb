GrowthValley::Application.routes.draw do

  devise_for :users, controllers: {:omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations', sessions: 'sessions', confirmations: 'confirmations', passwords: 'passwords' }

  devise_scope :user do
    post 'user/upload_profile_pic' => 'registrations#upload_profile_pic', as: 'upload_profile_pic'
    get 'user/inactive' => 'sessions#inactive'
  end

  get 'user/subjects' => 'users#list_subjects', as: 'user_subjects'
  post 'user/update_user_subjects' => 'users#update_user_subjects', as: 'update_user_subjects'
  
  resources :subjects
  resources :courses do
    resources :exams do
      resources :exam_questions
    end

    member do
	  get 'sections'
      get 'publish_unpublish'
    end

    collection do
      get 'my_courses'
      get 'rate_course', as: :rate
    end
  end
  resources :course_steps, only: [:index, :show, :update]
  resources :sections do
    resources :quizzes
  end
  resources :charges, path: 'subscriptions', only: [:index, :new, :create]
  resources :homes, only: :index do
    collection do
      get 'about_us', as: :about_us
      get 'resources', as: :resources
      get 'products', as: :products
      get 'blog', as: :blog
      get 'contact', as: :contact
      get 'terms', as: :terms
    end
  end
  match 'dashboard' => 'homes#dashboard', as: :dashboard
  match 'notifications' => 'homes#notification', as: :notification

  resources :learners, only: [:index, :show] do
	collection do
		match '/:course/:section/test' => 'learners_quizzes#new', as: :take_test
	end
    member do
      get 'subscribe_course', as: :subscribe_course
      get 'unsubscribe_course', as: :unsubscribe_course
    end
  end

  resources :learners_quizzes, only: [:new, :create]
  resources :learners_exams, only: [:new, :create]

  match 'contact_us' => 'contact_us#create', via: :post

  root to: 'homes#index'

  namespace :admin do
  	match 'change_password' => 'admin_users#edit'
  end
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
