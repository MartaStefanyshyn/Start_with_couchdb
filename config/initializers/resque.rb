require 'resque'
require 'resque/status_server'
require 'resque/job_with_status'

Resque.redis = 'localhost:6379'
Resque::Plugins::Status::Hash.expire_in = (60 * 60)
