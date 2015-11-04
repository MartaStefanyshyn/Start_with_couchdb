class PdfJob < ActiveJob::Base
  queue_as :qpdf

  def perform(html)
    pdf = WickedPdf.new.pdf_from_string(html)
    pdf_path = Rails.root.join('public', 'output.pdf')
    File.open(pdf_path, 'wb') do |file|
      file << pdf
    end
    doc = PdfSaver.create(title: 'pdf_output')
    doc.create_attachment(name: "pdf_file_#{Time.now}", file: File.open('public/output.pdf'))
    doc.save!
    File.delete(pdf_path) if File.exist?(pdf_path)
  end
end
