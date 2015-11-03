require 'rails_helper'

RSpec.describe PdfSaver, type: :model do
  it "should create valid pdf_saver" do
    expect(FactoryGirl.create(:pdf_saver)).to be_valid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:pdf_saver, title: nil)).to_not be_valid
  end

  it "grouplist is empty" do
    expect(PdfSaver.count).to eq 0
  end
  
  it "map with by_title" do
    pdf_saver = FactoryGirl.create(:pdf_saver, title: 'title')
    expect(PdfSaver.by_title(key: 'title').all).to eq([pdf_saver])
  end

  it "map with by_title" do
    group = FactoryGirl.create(:pdf_saver, title: 'title')
    expect(PdfSaver.by_title(key: 'title_t').all).to eq([])
  end

  it "map with by_title" do
    pdf_saver = FactoryGirl.create(:pdf_saver, title: 'title')
    pdf_saver2 = FactoryGirl.create(:pdf_saver)
    pdf_saver3 = FactoryGirl.create(:pdf_saver, title: 'title')
    expect(PdfSaver.by_title(key: 'title').all).to match_array([pdf_saver, pdf_saver3])
  end
end
