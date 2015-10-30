class PdfJob < ActiveJob::Base
  queue_as :qpdf

  def perform(html)
    pdf = WickedPdf.new.pdf_from_string(html)
    IO.write("output.pdf", pdf.force_encoding("UTF-8"))
  end
end
