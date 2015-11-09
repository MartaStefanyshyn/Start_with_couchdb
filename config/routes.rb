require 'resque/server'
Rails.application.routes.draw do
  get 'pdf_savers/index'

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
  mount Resque::Server.new, at: '/resque'
end
