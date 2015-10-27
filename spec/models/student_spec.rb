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

  it "is invalid without a surname" do
    student = FactoryGirl.create(:student)
    student2 = FactoryGirl.create(:student)
    expect(Student.by_name.count).to eq(2)
  end

  it "is invalid without a surname" do
    student = FactoryGirl.create(:student)
    expect(Student.by_name.first).to eq(student)
  end

  it "is invalid without a surname" do
    student = FactoryGirl.create(:student)
    expect(Student.by_name_and_surname.first).to eq(student)
  end

  it "is invalid without a surname" do
    student = FactoryGirl.create(:student)
    expect(Student.by_group_id.first).to eq(student)
  end

  it "studentlist is empty" do
    expect(Student.count).to eq 0
  end

end
