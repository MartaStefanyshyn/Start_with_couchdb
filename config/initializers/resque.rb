require 'resque'

Resque.redis = 'localhost:6379'
Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60)
