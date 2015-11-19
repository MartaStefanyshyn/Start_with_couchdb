require 'rails_helper'
RSpec.describe Api::StudentsController, type: :controller do
  describe 'GET index' do
    it 'response with 200 status' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested student to @student' do
      student = create(:student)
      get :show, id: student
      expect(assigns(:student)).to eq(student)

      content = response.body
      expect(content).to include 'name'
      expect(content).to include 'surname'
    end
    it 'respond with success' do
      student = create(:student)
      get :show, id: student
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    it 'creates a new student' do
      expect{
        post :create, student: FactoryGirl.attributes_for(:student)
      }.to change(Student, :count).by(1)
    end
    it 'does not create the student' do
      post :create, student: FactoryGirl.attributes_for(:student, name: nil)
      expect(Student.count).to eq(0)
    end
    it 'creates a new student' do
      post :create, {student: attributes_for(:student)}, format: :json

      expect(response).to be_success

      content = JSON.parse(response.body)
      expect(content).to include('name')
      expect(content).to include('surname')
    end
    it 'title responds with status unprocessable_entity' do
      post :create, {student: attributes_for(:student, name: nil)}, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT update' do
    before :each do
      @student = create(:student)
    end
    it 'located the requested student' do
      student = create(:student)
      put :update, id: @student, student: FactoryGirl.attributes_for(:student)
      expect(assigns(:student)).to eq(@student)
    end
    it 'changes student\'s attributes' do
      student = create(:student)
      put :update, id: @student,
                   student: FactoryGirl.attributes_for(:student, name: 'BBB')
      @student.reload
      expect(@student.name).to eq('BBB')
    end
    it 'located the requested student' do
      put :update, id: @student, student: FactoryGirl.attributes_for(:student), format: :json

      expect(response).to be_success

      content = JSON.parse(response.body)
      expect(content).to include 'name'
      expect(content).to include 'surname'
    end
    it 'does not update an group without title' do
      put :update, { id: @student, student: { name: nil } }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the category' do
      student = Student.create(name: 'aaa', surname: 'bbbb', group_id: 'bbbb')
      expect{
        delete :destroy, id: student
      }.to change(Student, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
