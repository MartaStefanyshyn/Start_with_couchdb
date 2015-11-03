require 'rails_helper'

RSpec.describe PdfJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later("<p>Hello</p>") }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in urgent queue' do
    expect(PdfJob.new.queue_name).to eq('qpdf')
  end

  it 'is in urgent queue' do
    PdfJob.perform_later("<p>Hello</p>")
    expect(enqueued_jobs.size).to eq(1) 
    perform_enqueued_jobs { PdfJob.perform_now("<p>Hello</p>") }
    expect(ActiveJob::Base.queue_adapter.performed_jobs.size).to eq(0)
  end

  # it 'is in urgent queue' do
  #   # assert_performed_jobs 1 do
  #   #   PdfJob.perform_later("<p>Hello</p>")
  #   # end
  #   # expect { job }
  #   #   .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(0)
  #   assert_enqueued_jobs 0
  #   PdfJob.perform_later("<p>Hello</p>")
  #   # assert_enqueued_jobs 1

  # end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end