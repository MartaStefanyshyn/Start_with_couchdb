class Api::PdfSaversController < ApplicationController
  before_action :create_pdf, except: [:index ]
  skip_before_action :verify_authenticity_token

  def index
    @pdf_savers = PdfSaver.all
    render json: @pdf_savers
  end

  def show
    @pdf_saver = PdfSaver.find(params[:id])
    render json: @pdf_saver
  end

  def load_pdf
    send_file "public/#{@pdf_saver.id}.pdf", :type=>"application/pdf", :x_sendfile=>true
  end

  def read_pdf
    send_file "public/#{@pdf_saver.id}.pdf", :type=>"application/pdf", disposition: 'inline'
  end

  def create_pdf
    @pdf_saver = PdfSaver.find(params[:id])
    attachment = @pdf_saver.attachments.first
    pdf = @pdf_saver.read_attachment(attachment[0])
    @pdf_path = Rails.root.join('frontend_part/src/app/pdf_saver', "#{@pdf_saver.id}.pdf")

    File.open(@pdf_path, 'wb') do |file|
      file << pdf
    end
  end
end


