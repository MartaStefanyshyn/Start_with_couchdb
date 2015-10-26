require 'couchrest_model'
class Group < CouchRest::Model::Base
	property :title, String
	design do
		view :by_title
	end

end
