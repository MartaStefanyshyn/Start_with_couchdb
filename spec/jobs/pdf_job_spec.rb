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

  it 'performs the job' do
    perform_enqueued_jobs do
      job.perform_now
    end
    expect(ActiveJob::Base.queue_adapter.performed_jobs.size).to eq(1)
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end