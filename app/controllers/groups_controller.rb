class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  
  def index
    @groups = Group.search(params[:search])
  end

  def show
    @group_students = @group.group_students()
  end

  
  def new
    @group = Group.new
  end

  
  def edit
  end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    respond_to do |format|
      if @group.update_attributes(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def pdf_generator
    html = render_to_string(:action => :index, :template => "groups/index.html")
    PdfJob.perform_later(html)
    flash[:notice] = "pdf was generated"
    redirect_to groups_path
  end

  private
    
    def set_group
      @group = Group.find(params[:id])
    end

    
    def group_params
      params.require(:group).permit(:title)
    end
end
