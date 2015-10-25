require 'couchrest_model'
class Student < CouchRest::Model::Base
  
  belongs_to :group
  property :name,      String
  property :surname,      String

  design do 

  	view :by_name,
  	  :map => "function(doc){
  	      if (doc['type'] == 'Student' && doc.name) {
              emit(doc.name, 1);
          }
        }",
       :reduce =>
        "function(keys, values, rereduce) {
          return sum(values);
        }"
  end

end
