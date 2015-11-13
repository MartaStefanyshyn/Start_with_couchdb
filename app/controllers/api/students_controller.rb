class Api::StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @groups = Group.all
    @students = Student.search(params[:search])
    render json: @students
  end

  def show
    group = Group.find(_id: @student.group_id)
    render json: @student
  end

  def new
    @student = Student.new
    @groups = Group.all
  end

  def edit
    @groups = Group.all
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      render json: @student
    else
      head :unprocessable_entity
    end
  end

  def update
    if @student.update_attributes(student_params)
      render json: @student
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    head :no_content
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :surname, :group_id)
  end
end
