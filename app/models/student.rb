require 'couchrest_model'
class Student < CouchRest::Model::Base

  
  belongs_to :group
  property :name,      String
  property :surname,      String


  design do 
    view :by_name_and_surname,
    :map => "function(doc){
          if ((doc['type'] == 'Student') && (doc.name != null) && (doc.surname != null)) {
              emit([doc.name, doc.surname], doc);
          }
        }"
  	view :by_name,
  	  :map => "function(doc){
  	      if (doc['type'] == 'Student' && doc.name != null) {
              emit(doc.name, 1);
          }
        }"
    view :by_group_id,
  	  :map => "function(doc){
  	      if (doc['type'] == 'Student' && doc['group_id'] != null) {
              emit(doc.group_id, doc);
          }
        }"
  end

  def self.search(search)
    if search && search != ''
      group = Group.by_title(key: search).first
      by_group_id(key: group.id).all
    else
      all
    end
  end

  validates_presence_of :name, :surname
end
