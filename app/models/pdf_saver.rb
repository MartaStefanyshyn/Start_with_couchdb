require 'couchrest_model'
class PdfSaver < CouchRest::Model::Base
  property :title, String

  design do
    view :by_title
    view :by_attachment,
          map:   "function(doc) {
          if (doc['type'] == 'PdfSaver' && doc._attachments) {
              emit(doc._id, doc._attachments);
          }
        }"
  end

  timestamps!

  validates_presence_of :title
end
