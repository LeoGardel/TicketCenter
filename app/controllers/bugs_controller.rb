class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /projects/:project_id/bugs
  # GET /projects/:project_id/bugs.json
  def index
    @bugs = Bug.where(project_id: params[:project_id])
  end

  # GET /projects/:project_id/bugs/1
  # GET /projects/:project_id/bugs/1.json
  def show
  end

  # GET /projects/:project_id/bugs/new
  def new
    @bug = Bug.new(project_id: params[:project_id])
  end

  # GET /projects/:project_id/bugs/1/edit
  def edit
  end

  # POST /projects/:project_id/bugs
  # POST /projects/:project_id/bugs.json
  def create
    @bug = Bug.new(bug_params)
    @bug.project_id = params[:project_id]
    
    set_status_audit

    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_bug_path(project_id: @bug.project_id, id: @bug.id), notice: 'Bug was successfully created.' }
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

    respond_to do |format|
      if @bug.update(bug_params.merge({project_id: params[:project_id]}))
        format.html { redirect_to project_bug_path(project_id: @bug.project_id, id: @bug.id), notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_bug
      @bug = Bug.find(params[:id])
    end

    def set_status_audit
      @bug.user_status = current_user.id
      @bug.date_status = DateTime.now
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:description, :status)
    end
end
