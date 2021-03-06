require 'couchrest_model'
class Student < CouchRest::Model::Base
  belongs_to :group
  property :name, String
  property :surname, String

  design do
    view :by_name_and_surname,
         map: "function(doc){
               if ((doc['type'] == 'Student') && (doc.name != null) && (doc.surname != null))
               {
                   emit([doc.name, doc.surname], doc);
               }
             }"
    view :by_name,
         map: "function(doc){
               if (doc['type'] == 'Student' && doc.name != null)
               {
                   emit(doc.name, 1);
               }
             }"
    view :by_group_id,
         map: "function(doc){
               if (doc['type'] == 'Student' && doc['group_id'] != null) {
                   emit(doc.group_id, 1);
               }
             }",
         reduce: '_sum'
    view :by_group,
         map: "function(doc){
               if (doc['type'] == 'Student' && doc['group_id'] != null) {
                   emit(doc.group_id, {_id: doc.group_id, name: doc.name});
               }
             }"
  end

  def self.search(search)
    if search && search != ''
      by_name(key: search).all
    else
      all
    end
  end

  validates_presence_of :name, :surname, :group_id
end
