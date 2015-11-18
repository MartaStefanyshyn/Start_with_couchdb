# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'factory_girl'
require 'shoulda/matchers'
require 'capybara/rspec'
require 'simplecov'
require 'rspec/active_job'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/lib/'
  add_filter '/vendor/'

  add_group 'Controllers', 'app/controllers/api'
  add_group 'Models', 'app/models'
  add_group 'Views', 'app/views/students'
  add_group 'Views', 'app/views/groups'
  add_group 'Jobs', 'app/jobs'
end

RSpec.configure do |config|
  config.include(RSpec::ActiveJob)
  config.include FactoryGirl::Syntax::Methods
  config.after(:each) do
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
    ActiveJob::Base.queue_adapter.performed_jobs = []
  end
  config.before(:each) do
    CouchRest::Model::Base.database.recreate! rescue nil
  end
  config.include Capybara::DSL
  config.infer_spec_type_from_file_location!
end
