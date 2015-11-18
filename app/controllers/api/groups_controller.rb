class Api::GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @groups = Group.students_count.reduce.group_level(1).rows
    render json: @groups
  end

  def search_group
    @groups = Group.search(params[:search])
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
    @group = Group.new(group_params)
    if @group.save
      render json: @group
    else
      head :unprocessable_entity
    end
  end

  def update
    if @group.update_attributes(group_params)
      render json: @group
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @group.destroy
    head :no_content
  end

  def pdf_generator
    PdfJob.perform_later()
    render json: @groups
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:title)
  end
end
