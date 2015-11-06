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

    view :students_count,
         map: "function(doc) {
                  if (doc['type'] == 'Group') {
                     emit(doc._id, doc);
                  }
                  if (doc['type'] == 'Student') {
                      emit(doc.group_id, doc);
                  }
                }",
        reduce: "function(keys, values) {
                    var title;
                    var count = 0;
                    for(var i = 0; i < values.length; i++) {
                      v = values[i];
                      if (v.type == 'Group') {
                        title = v.title;
                      } else {
                      count++;
                      }
                    }
                    return [title, count];
                   }"

  end

  def group_students
    Student.by_group_id(key: self.id).all
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
