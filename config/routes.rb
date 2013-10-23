GrowthValley::Application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  
  resources :subjects
  resources :courses do
    resources :exams do
      resources :exam_questions
    end

    member do
      get 'publish_unpublish'
    end

    collection do
      get 'rate_course', as: :rate
    end
  end
  resources :course_steps, only: [:index, :show, :update]
  resources :sections do
    resources :quizzes
  end
  resources :charges
  resources :homes, only: :index

  resources :learners, only: [:index, :show] do
    member do
      get 'subscribe_course', as: :subscribe_course
    end
  end

  root to: 'homes#index'

  namespace :admin do
  	match 'change_password' => 'admin_users#edit'
  end
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
