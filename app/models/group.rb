require 'couchrest_model'
class Group < CouchRest::Model::Base
  property :title, String
  design do
    view :by_title,
         map: "function(doc){
                 if ((doc['type'] == 'Group') && (doc.title != null)) {
                   emit(doc.title, doc);
                 }
               }"
  end

  def group_students
    Student.by_group(key: id).all
  end

  def group_students_count
    Student.by_group(key: id).count
  end

  validates_presence_of :title

  def self.search(search)
    if search && search != ''
      by_title(key: search)
    else
      all
    end
  end
end
