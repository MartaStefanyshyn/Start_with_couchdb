require 'rails_helper'
RSpec.describe StudentsController, type: :controller do
  describe "GET index" do
    # it "assigns @students" do
    #   student = Student.create(name: 'aaa', surname: 'bbbb')
    #   get :index
    #   #expect(assigns(:students)).to eq([student])
    #   assigns(:students).should == [student]
    # end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it 'response with 200 status' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET #new" do
    it 'assigns a new student to @student' do
     get :new
    expect(assigns(:student)).to be_a_new(Student)
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
end