class Api::PdfSaversController < ApplicationController
  before_action :create_pdf, only: [:load_pdf, :read_pdf]
  skip_before_action :verify_authenticity_token

  def index
    @pdf_savers = PdfSaver.all
    render json: @pdf_savers
  end

  def load_pdf
    send_file "public/#{@attachment}.pdf", :type=>"application/pdf", :x_sendfile=>true
  end

  def read_pdf
    send_file "public/#{@attachment}.pdf", :type=>"application/pdf", disposition: 'inline'
  end

  private
  def create_pdf
    @pdf_saver = PdfSaver.find(params[:id])
    attachment = @pdf_saver.attachments.first
    pdf = @pdf_saver.read_attachment(attachment[0])
    @pdf_path = Rails.root.join('public', "#{attachment[0]}.pdf")

    File.open(@pdf_path, 'wb') do |file|
      file << pdf
    end
    @attachment = attachment[0]
  end
end


