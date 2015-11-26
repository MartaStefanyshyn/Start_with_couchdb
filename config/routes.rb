require 'resque/server'
Rails.application.routes.draw do
  namespace :api do
    get "log_out" => "sessions#destroy", :as => "log_out"
    resources :groups do
      collection do
        get :pdf_generator
        get :search_group
      end
    end
    resources :students
    resources :pdf_savers do
      member do
        get :read_pdf
        get :load_pdf
      end
    end
    resources :sessions
    resources :users
    get 'jobs/:id/job_status' => 'jobs#job_status'
    mount Resque::Server.new, at: '/resque'
  end
end
