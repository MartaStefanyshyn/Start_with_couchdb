require 'couchrest_model'
class Student < CouchRest::Model::Base
  
  belongs_to :group
  property :name,      String
  property :surname,      String


  design do 
    view :by_id
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
    view :by_group_id,
  	  :map => "function(doc){
  	      if (doc['type'] == 'Student' && doc.group_id) {
              emit(doc.group_id, 1);
          }
        }",
       :reduce =>
        "function(keys, values, rereduce) {
          return sum(values);
        }"    

  end

end
