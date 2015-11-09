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

  # describe "Pdf read and download" do
  #   it 'sends_file' do
  #   end
  # end
end
