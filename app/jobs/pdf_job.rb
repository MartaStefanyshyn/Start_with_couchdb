class PdfJob < ActiveJob::Base
  include Resque::Plugins::Status
  queue_as :qpdf

  def perform()
    puts self.status
    sleep(10)
    @groups = Group.students_count.reduce.group_level(1).rows
    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths

    pdf_html = av.render :template => "groups/pdf.html.erb", :layout => nil, :locals => {:@groups => @groups}
    pdf = WickedPdf.new.pdf_from_string(pdf_html, :page_size => 'Letter')

    pdf_path = Rails.root.join('public', 'output.pdf')

    File.open(pdf_path, 'wb') do |file|
      file << pdf
    end

    doc = PdfSaver.create(title: 'pdf_output')
    doc.create_attachment(name: "pdf_file_#{Time.now}", file: File.open('public/output.pdf'))
    doc.save!
    File.delete(pdf_path) if File.exist?(pdf_path)
    puts self.status
  end
end
