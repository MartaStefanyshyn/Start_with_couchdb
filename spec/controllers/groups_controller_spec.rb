require 'rails_helper'
RSpec.describe GroupsController, type: :controller do
  describe "GET index" do
    it "assigns @group" do
      group = create(:group)
      get :index
      expect(assigns(:groups)).to match_array([group])
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it 'response with 200 status' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET #show" do
  it "assigns the requested group to @group" do
    group = create(:group)
    get :show, id: group
    expect(assigns(:group)).to eq(group)
  end
    it "renders the #show view" do
    group = create(:group)
    get :show, id: group
    expect( response ).to render_template( :show )
  end
  it 'respond with success' do
       group = create(:group)
       get :show, id: group
       expect(response).to be_success
    end
  end

  describe "GET #new" do
    it 'assigns a new group to @group' do
     get :new
     expect(assigns(:group)).to be_a_new(Group)
    end
  end

  describe "POST #create" do
    it "creates a new group" do
      expect{
        post :create, group: FactoryGirl.attributes_for(:group)
      }.to change(Group,:count).by(1)
    end
    it 'does not create the group' do
       post :create, group: FactoryGirl.attributes_for(:group, title: nil)
       expect(Group.count).to eq(0)
     end
     it "re-renders the new method" do
      post :create, group: FactoryGirl.attributes_for(:group, title: nil)
      expect(response).to render_template :new
    end
   end

   describe 'PUT update' do
    it "located the requested group" do
      group = create(:group)
      put :update, id: group, group: FactoryGirl.attributes_for(:group)
      expect(assigns(:group)).to eq(group)      
    end
    it "changes group's attributes" do
      group = create(:group)
      put :update, id: group,
        group: FactoryGirl.attributes_for(:group, title: 'aaa')
      group.reload
      expect(group.title).to eq('aaa')
    end
    it "re-renders the edit method" do
      group = create(:group)
      put :update, id: group, group: FactoryGirl.attributes_for(:group, title: nil)
      expect(response).to render_template :edit
    end
   end

  describe 'DELETE destroy' do
    it "deletes the category" do
    group = Group.create(title: "aaa")
    expect{
    delete :destroy, id: group
      }.to change(Group, :count).by(-1)
    end
  end 
end