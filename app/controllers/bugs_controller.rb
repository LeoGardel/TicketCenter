class BugsController < ApplicationController
  before_action :set_project
  before_action :set_bug, only: [:show, :edit, :update]
  before_action :authenticate_user!

  # GET /projects/:project_id/bugs
  # GET /projects/:project_id/bugs.json
  def index
    @bugs = @project.bugs.all
  end

  # GET /projects/:project_id/bugs/1
  # GET /projects/:project_id/bugs/1.json
  def show
  end

  # GET /projects/:project_id/bugs/new
  def new
    @bug = @project.bugs.new
  end

  # GET /projects/:project_id/bugs/1/edit
  def edit
  end

  # POST /projects/:project_id/bugs
  # POST /projects/:project_id/bugs.json
  def create
    @bug = @project.bugs.new(bug_params)
    
    set_status_audit
    set_number

    respond_to do |format|
      if @bug.save
        format.html { redirect_to [@project, @bug], notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/:project_id/bugs/1
  # PATCH/PUT /projects/:project_id/bugs/1.json
  def update
    set_status_audit
    set_number

    respond_to do |format|
#      if @bug.update(bug_params.merge({project_id: params[:project_id]}))
      if @bug.update(bug_params)
        format.html { redirect_to [@project, @bug], notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_bug
      @bug = @project.bugs.find(params[:id])
    end

    def set_status_audit
      @bug.user_status_id = current_user.id
      @bug.date_status = DateTime.now
    end

    def set_number
      max_num = @project.bugs.maximum(:number)
      @bug.number = max_num.nil? ? 1 : max_num + 1
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:project_id, :description, :status)
    end
end
