require 'rails_helper'
RSpec.describe StudentsController, type: :controller do
  describe "GET index" do

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
  it "assigns the requested student to @student" do
    student = create(:student)
    get :show, id: student
    expect(assigns(:student)).to eq(student)
  end
    it "renders the #show view" do
    student = create(:student)
    get :show, id: student
    expect( response ).to render_template( :show )
  end
  it 'respond with success' do
       student = create(:student)
       get :show, id: student
       expect(response).to be_success
    end
  end

  describe "GET #new" do
    it 'assigns a new student to @student' do
     get :new
     expect(assigns(:student)).to be_a_new(Student)
    end
  end

  describe "POST #create" do
    it "creates a new student" do
      expect{
        post :create, student: FactoryGirl.attributes_for(:student)
      }.to change(Student,:count).by(1)
    end
    it 'does not create the student' do
       post :create, student: FactoryGirl.attributes_for(:student, name: nil)
       expect(Student.count).to eq(0)
     end
     it "re-renders the new method" do
      post :create, student: FactoryGirl.attributes_for(:student, name: nil)
      expect(response).to render_template :new
    end
   end

   describe 'PUT update' do
     it "located the requested student" do
      student = create(:student)
      put :update, id: student, student: FactoryGirl.attributes_for(:student)
      expect(assigns(:student)).to eq(student)      
    end
    it "changes student's attributes" do
      student = create(:student)
      put :update, id: student,
        student: FactoryGirl.attributes_for(:student, name: "BBB")
      student.reload
      expect(student.name).to eq("BBB")
    end
    it "re-renders the edit method" do
      student = create(:student)
      put :update, id: student, student: FactoryGirl.attributes_for(:student, name: nil)
      expect(response).to render_template :edit
    end
   end

  describe 'DELETE destroy' do
    it "deletes the category" do
    student = Student.create(name: 'aaa', surname: 'bbbb', group_id: 'bbbb')
    expect{
    delete :destroy, id: student
      }.to change(Student, :count).by(-1)
    end
  end 
end
