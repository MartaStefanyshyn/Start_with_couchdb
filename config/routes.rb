require 'resque/server'
Rails.application.routes.draw do
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "users#new"
  resources :users
  resources :sessions
  resources :groups do
    collection do
      get :pdf_generator
      get :search_group
    end
  end
  namespace :api do
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
    get 'jobs/:id/job_status' => 'jobs#job_status'
    mount Resque::Server.new, at: '/resque'
  end
end
