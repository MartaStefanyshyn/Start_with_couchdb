class PdfJob < ActiveJob::Base
  queue_as :qpdf

  def perform(html)
  	@db = CouchRest.database("http://127.0.0.1:5984/rails_couchdb_development")
    pdf = WickedPdf.new.pdf_from_string(html)
    pdf_path = Rails.root.join('public', "output.pdf")
    File.open(pdf_path, 'wb') do |file|
     file << pdf
    end
    doc = PdfSaver.create(title: "pdf_output" )
    doc.create_attachment(name: "pdf_file", file: File.open("public/output.pdf"))
    doc.save!
  end
end
