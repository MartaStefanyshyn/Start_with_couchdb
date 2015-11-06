class PdfSaversController < ApplicationController
  def index
    @pdf_savers = PdfSaver.all
  end
end
