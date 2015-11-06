require 'resque/server'
Rails.application.routes.draw do
  get 'pdf_savers/index'

  resources :groups do
    collection do
      get :pdf_generator
    end
  end
  resources :students
  resources :pdf_savers
  mount Resque::Server.new, at: '/resque'
end
