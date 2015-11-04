require 'rails_helper'
describe Student, type: :model  do
  it 'should create valid student' do
    expect(FactoryGirl.create(:student)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:student, name: nil)).to_not be_valid
  end

  it 'is invalid without a surname' do
    expect(FactoryGirl.build(:student, surname: nil)).to_not be_valid
  end

  it 'studentlist is empty' do
    expect(Student.count).to eq 0
  end

  it 'should map with by_name' do
    student = FactoryGirl.create(:student)
    student2 = FactoryGirl.create(:student)
    expect(Student.by_name.count).to eq(2)
  end

  it 'map with by_name' do
    student = FactoryGirl.create(:student, name: 'AAA')
    expect(Student.by_name(key: 'AAA').first).to eq(student)
  end

  it 'map with by_name' do
    student = FactoryGirl.create(:student, name: 'AAA')
    expect(Student.by_name(key: 'BBB').first).to eq(nil)
  end

  it 'map with by_name_and_surname' do
    student = FactoryGirl.create(:student)
    expect(Student.by_name_and_surname.first).to eq(student)
  end

  it 'map with by_name_and_surname' do
    student = FactoryGirl.create(:student, name: 'n', surname: 's')
    student2 = FactoryGirl.create(:student)
    expect(Student.by_name_and_surname(key: ['n', 's']).all).to eq([student])
  end

  it 'map with by_group_id' do
    student = FactoryGirl.create(:student)
    expect(Student.by_group_id.first).to eq(student)
  end

  it 'map with by_group_id' do
    student = FactoryGirl.create(:student, group_id: '000')
    student2 = FactoryGirl.create(:student)
    student3 = FactoryGirl.create(:student, group_id: '000')
    expect(Student.by_group_id(key: '000').all).to match_array([student, student3])
  end

  it 'searches right student_by_name' do
    student = FactoryGirl.create(:student, name: 'test_name')
    student2 = FactoryGirl.create(:student, name: 'test_name2')
    expect(Student.search('test_name2')).to eq([student2])
  end
  it 'searches a few student_by_name' do
    student = FactoryGirl.create(:student, name: 'test_name')
    student2 = FactoryGirl.create(:student, name: 'test_name')
    expect(Student.search('test_name')).to match_array([student, student2])
  end

  it 'searches student_by_name: shows all when search field is empty' do
    student = FactoryGirl.create(:student)
    student2 = FactoryGirl.create(:student)
    student3 = FactoryGirl.create(:student)
    expect(Student.search('')).to match_array([student, student2, student3])
  end
end
