class Api::GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_action :check_authentication, except: [:index, :show]

  def index
    @groups = Group.students_count.reduce.group_level(1).rows
    render json: @groups
  end

  def search_group
    @groups = Group.search(params[:search])
    render json: @groups
  end

  def show
    @group_students = Student.by_group_id(key: @group.id).all
    response = {group: @group, group_st: @group_students}
    render json: response
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      render json: @group, status: :created
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def update
    if @group.update_attributes(params[:group])
      head :no_content
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy
    @group_students = Student.by_group_id(key: @group.id).all
    @group_students.each do |student|
      student.destroy
    end
    render json: @group.errors, status: :no_content
  end

  def pdf_generator
    @job_id = PdfJob.create
    output = { job_id: @job_id}.to_json
    render json: { job_id: @job_id}
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end
end
