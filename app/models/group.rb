require 'couchrest_model'
class Group < CouchRest::Model::Base
	property :title, String
	design do
		view :by_title
	end

	def group_students
      students = Student.by_group_id(:startkey => [self.id], :endkey => [self.id,{}]).all
    end

end
