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
        }",
       :reduce =>
        "function(keys, values, rereduce) {
          return sum(values);
        }"
    view :by_group_id,
  	  :map => "function(doc){
  	      if (doc['type'] == 'Student' && doc.group_id) {
              emit([doc.group_id], null);
          }
        }" 
    #     view :by_group_id, :map => "
    # function(d) {
    #   t = d['type'];
    #   if ((t == 'Student' || t == 'Group') && d['group_id']) {
    #     emit(d.name, 1);
    #   }
    # }",  
    # :reduce =>
    #     "function(keys, values, rereduce) {
    #       return sum(values);
    #     }"  

  end
  validates_presence_of :name, message: "can not be blank"
end
