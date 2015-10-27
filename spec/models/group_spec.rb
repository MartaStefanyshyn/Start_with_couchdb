require 'rails_helper'

describe Student, :type => :model  do
  it "should create valid group" do
    expect(FactoryGirl.create(:group)).to be_valid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:group, title: nil)).to_not be_valid
  end

  it "studentlist is empty" do
    expect(Group.count).to eq 0
  end
  
  it "studentlist is empty" do
    group = FactoryGirl.create(:group)
    student = FactoryGirl.create(:student, group_id: group.id)
    expect(group.group_students).to eq([student])
  end
end
