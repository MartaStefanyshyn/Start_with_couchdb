require 'resque/server'
Rails.application.routes.draw do
  resources :groups do
    collection do
      get :pdf_generator
    end
  end
  resources :students
  mount Resque::Server.new, at: '/resque'
end
