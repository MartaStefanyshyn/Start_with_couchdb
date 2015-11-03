require 'couchrest_model'
class PdfSaver < CouchRest::Model::Base
	property :title,      String
    
    design do 
      view :by_title
    end

    timestamps!

    validates_presence_of :title
end

