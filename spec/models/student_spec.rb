require 'rails_helper'

describe Student, :type => :model  do
  it "should create valid student" do
    expect(FactoryGirl.create(:student)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:student, name: nil)).to_not be_valid
  end

  it "is invalid without a surname" do
    expect(FactoryGirl.build(:student, surname: nil)).to_not be_valid
  end

  # it "is invalid without a surname" do
  #   student = FactoryGirl.create(:student)
  #   expect(student).to belong_to(:group)
  # end

  it "studentlist is empty" do
    expect(Student.count).to eq 0
  end

end
