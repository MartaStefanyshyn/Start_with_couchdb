require 'couchrest_model'
class Job < CouchRest::Model::Base
  property :job_id, String
  property :status, String

  design do
    view :by_job_id
  end
end
