class PdfSaversController < ApplicationController
  def index
    @pdf_savers = PdfSaver.all
  end

  def load_pdf
    @pdf_saver = PdfSaver.find(params[:id])
    attachment = @pdf_saver.attachments.first
    pdf = @pdf_saver.read_attachment(attachment[0])
    pdf_path = Rails.root.join('public', "#{attachment[0]}.pdf")

    File.open(pdf_path, 'wb') do |file|
      file << pdf
    end
    send_file "public/#{attachment[0]}.pdf", :type=>"application/pdf", :x_sendfile=>true
  end

  def read_pdf
    @pdf_saver = PdfSaver.find(params[:id])
    attachment = @pdf_saver.attachments.first
    pdf = @pdf_saver.attachment_url(attachment[0])
    pdf_path = Rails.root.join('public', "#{attachment[0]}.pdf")

    File.open(pdf_path, 'wb') do |file|
      file << pdf
    end
    send_file "public/#{attachment[0]}.pdf", :type=>"application/pdf", disposition: 'inline'
  end
end
