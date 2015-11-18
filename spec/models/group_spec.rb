require 'rails_helper'
describe Group, type: :model  do
  it 'should create valid group' do
    expect(FactoryGirl.create(:group)).to be_valid
  end

  it 'is invalid without a title' do
    expect(FactoryGirl.build(:group, title: nil)).to_not be_valid
  end

  it 'grouplist is empty' do
    expect(Group.count).to eq 0
  end

  it 'map with by_title' do
    group = FactoryGirl.create(:group, title: 'title')
    expect(Group.by_title(key: 'title').all).to eq([group])
  end

  it 'map with by_title' do
    group = FactoryGirl.create(:group, title: 'title')
    expect(Group.by_title(key: 'title_t').all).to eq([])
  end

  it 'map with by_title' do
    group = FactoryGirl.create(:group, title: 'title')
    group2 = FactoryGirl.create(:group)
    group3 = FactoryGirl.create(:group, title: 'title')
    expect(Group.by_title(key: 'title').all).to match_array([group, group3])
  end

  it 'map with students_count' do
    group = FactoryGirl.create(:group)
    student = FactoryGirl.create(:student, group_id: group.id)
    expect(Group.students_count.reduce.group_level(1).values[0]).to eq([group.title, 1])
  end

  it 'searches right group_by_title' do
    group = FactoryGirl.create(:group, title: 'test_title')
    group2 = FactoryGirl.create(:group, title: 'test_title2')
    expect(Group.search('test_title2').all).to eq([group2])
  end
  it 'searches a few group_by_title' do
    group = FactoryGirl.create(:group, title: 'test_title')
    group2 = FactoryGirl.create(:group, title: 'test_title')
    expect(Group.search('test_title').all).to match_array([group, group2])
  end

  it 'searches group_by_title: shows all when search field is empty' do
    group = FactoryGirl.create(:group)
    group2 = FactoryGirl.create(:group)
    group3 = FactoryGirl.create(:group)
    expect(Group.search('').all).to match_array([group, group2, group3])
  end
end
