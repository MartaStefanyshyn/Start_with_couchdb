require 'rails_helper'

RSpec.describe Api::PdfSaversController, type: :controller do

  describe "GET #index" do
    it 'assigns @pdf_savers' do
      pdf_saver = PdfSaver.create(title: 'test')
      get :index
      expect(assigns(:pdf_savers)).to match_array([pdf_saver])
    end
    it 'response with 200 status' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
