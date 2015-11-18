require 'rails_helper'
RSpec.describe Api::GroupsController, type: :controller do
  describe 'GET index' do
    it 'response with 200 status' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET search_group' do
    it 'renders the index template' do
      group = create(:group)
      get :search_group
      expect(assigns(:groups)).to match_array([group])
    end
  end

  describe 'GET #show' do
    before :each do
      @group = create(:group)
    end
    it 'render group' do
      get :show, id: @group, format: :json
      expect(assigns(:group)).to eq(@group)

      content = response.body
      expect(content).to include 'title'
      expect(content).to include '_id'
    end
    it 'respond with success' do
      get :show, id: @group
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    it 'creates a new group' do
      post :create, {group: attributes_for(:group)}, format: :json

      expect(response).to be_success

      content = JSON.parse(response.body)
      expect(content).to include('title')
    end
    it 'creates a new group' do
      expect{
        post :create, group: FactoryGirl.attributes_for(:group)
      }.to change(Group, :count).by(1)
    end
    it 'title responds with status unprocessable_entity' do
      post :create, {group: attributes_for(:group, title: nil)}, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT update' do
    before :each do
      @group = create(:group)
    end
    it 'located the requested group' do
      put :update, id: @group, group: FactoryGirl.attributes_for(:group), format: :json

      expect(response).to be_success

      content = JSON.parse(response.body)
      expect(content).to include('title')
      expect(content).to include('_id')
      expect(content).to include('_rev')
    end
    it 'changes group\'s attributes' do
      put :update, id: @group,
                   group: FactoryGirl.attributes_for(:group, title: 'aaa')
      @group.reload
      expect(@group.title).to eq('aaa')
    end
    it 'does not update an group without title' do
      put :update, { id: @group, group: { title: nil } }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes group' do
      group = create(:group)
      expect{
        delete :destroy, id: group, format: :json
      }.to change(Group,:count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'pdf_generator' do
    it 'redirect to index' do
      get :pdf_generator
      PdfJob.perform_later()
      expect(response).to be_success
    end
  end
end
