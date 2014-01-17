GrowthValley::Application.routes.draw do

  namespace :blog do
    get '/' => 'posts#index'
    get 'page/:page' => 'posts#index', as: "posts_page"
    get "/tags/:tag" =>"tags#show", as: "tags_page"

    namespace :admin do
      get "/" => "posts#index", as:  ""
      get "logout" => "sessions#destroy"
      get "login" => "sessions#new"
      resources :sessions
      resources :posts
      resources :users
      get "comments" => "comments#show", as: "comments"
    end
    # get "*post_url" => "posts#show", as:  "post"
  end

  devise_for :users, controllers: {:omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations', sessions: 'sessions', confirmations: 'confirmations', passwords: 'passwords' }

  devise_scope :user do
    post 'user/upload_profile_pic' => 'registrations#upload_profile_pic', as: 'upload_profile_pic'
    get 'user/inactive' => 'sessions#inactive'
  end

  get 'user/subjects' => 'users#list_subjects', as: 'user_subjects'
  post 'user/update_user_subjects' => 'users#update_user_subjects', as: 'update_user_subjects'
  get 'user/review_exams' => 'users#review_exams', as: 'review_exams'
  get 'user/reviewed_exams' => 'users#reviewed_exams', as: 'reviewed_exams'
  get 'user/exam/review' => 'users#exam_review', as: 'review_exam'
  post 'user/exam/submit_review' => 'users#submit_review', as: 'submit_review'
  get 'user/exam/result' => 'users#exam_result', as: 'exam_result'
  post 'user/exam/submit_result' => 'users#submit_result', as: 'submit_result'
  post 'courses/:course_id/teacher/subscribe' => 'users#subscribe_teacher', as: 'subscribe_teacher'
  get 'user/analytics' => 'users#analytics' , as: 'course_analytics'
  resources :bundles do
    member do
      get 'make_active'
      get 'toggle_available'
    end

    collection do
      get 'my_bundles'
    end
  end
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
  get 'subscriptions/success' => 'charges#success', as: 'successful_payment'
  resources :premium_courses, only: [:new]
  get 'premium_course_subscription/success' => 'premium_courses#success', as: 'successful_premium_course_subscription'
  resources :homes, only: :index do
    collection do
      get 'about_us', as: :about_us
      get 'resources', as: :resources
      get 'products', as: :products
      get 'blog', as: :blog
      get 'contact', as: :contact
      get 'terms', as: :terms
      get 'information', as: :information
      get 'for_organizations', as: :for_organizations
      get 'for_people', as: :for_people
      get 'faq', as: :faq
      get 'how_it_works', as: :how_it_works
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
