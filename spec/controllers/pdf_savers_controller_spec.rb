require 'rails_helper'

RSpec.describe PdfSaversController, type: :controller do

  describe "GET #index" do
    it 'assigns @pdf_savers' do
      pdf_saver = PdfSaver.create(title: 'test')
      get :index
      expect(assigns(:pdf_savers)).to match_array([pdf_saver])
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'response with 200 status' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "Pdf read and download" do
    it 'should allow to read file' do
      doc = PdfSaver.create(title: 'pdf_output')
      doc.create_attachment(name: "pdf_file", file: File.open('public/test.pdf'))
      doc.save!
      get :read_pdf, id: doc
      expect(response.headers["Content-Type"]).to eq("application/pdf")
      expect(response.headers["Content-Disposition"]).to eq("inline; filename=\"pdf_file.pdf\"")
    end
    it 'should allow to load file' do
      doc = PdfSaver.create(title: 'pdf_output')
      doc.create_attachment(name: "pdf_file", file: File.open('public/test.pdf'))
      doc.save!
      get :load_pdf, id: doc
      expect(response.headers["Content-Type"]).to eq("application/pdf")
      expect(response.headers["Content-Disposition"]).to eq("attachment; filename=\"pdf_file.pdf\"")
    end
  end
end
