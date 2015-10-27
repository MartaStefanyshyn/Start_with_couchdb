require 'couchrest_model'
class Student < CouchRest::Model::Base

  
  belongs_to :group
  property :name,      String
  property :surname,      String


  design do 
    view :by_name_and_surname
  	view :by_name,
  	  :map => "function(doc){
  	      if (doc['type'] == 'Student' && doc.name) {
              emit(doc.name, 1);
          }
        }"
    view :by_group_id,
  	  :map => "function(doc){
  	      if (doc['type'] == 'Student' && doc['group_id']) {
              emit([doc.group_id, 1, doc.name], doc);
          }
        }"

  end
  validates_presence_of :name, :surname
end
