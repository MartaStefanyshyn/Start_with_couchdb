require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_resource/railtie'
require 'active_model/railtie'
require 'rails/test_unit/railtie'
require 'wicked_pdf'

Bundler.require(*Rails.groups)

module RailsCouchdb
  class Application < Rails::Application
    config.active_job.queue_adapter = :resque
    config.middleware.use WickedPdf::Middleware, {}
  end
end
