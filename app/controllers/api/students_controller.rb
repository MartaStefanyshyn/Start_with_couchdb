class Api::StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_action :check_authentication, except: [:index, :show]

  def index
    @groups = Array.new
    @students = Student.search(params[:search])
    @students.each do |student|
      group = Group.by_id(key: student.group_id).first
      @groups.push group.title
    end
    response = {students: @students, groups: @groups}
    render json: response
  end

  def show
    @group = Group.by_id(key: @student.group_id).first
    response = {student: @student, group: @group}
    render json: response
  end

  def new
    @groups = Group.all
  end

  def edit
    @groups = Group.all
  end

  def create
    @student = Student.new(params[:student])

    if @student.save
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def update
    if @student.update_attributes(params[:student])
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
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
end
