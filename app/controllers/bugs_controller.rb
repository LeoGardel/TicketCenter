require 'slack-notifier'

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
    @bug = @project.bugs.new(bug_params.merge!(user_status: current_user))
    respond_to do |format|
      if @bug.save
        send_slack_notification ( {create: true} )
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
    respond_to do |format|
      if @bug.update(bug_params.merge!(user_status: current_user))
        send_slack_notification ( {update: true} )
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

    def send_slack_notification config_attr
      # Creating object for notifying Slack members. WebHook for testpipefyworkspace.slack.com
      notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL'],
       username: "TicketCenterApp",
       channel: "#tcappreports"

      if config_attr[:create]
        message = "Bug *\##{@bug.number}* was created on project *#{@project.name}*. It is *#{@bug.status}* and was initialized with the following description:\n\n#{@bug.description} \n\nYou can access this bug clicking <#{project_bug_url(@project,@bug)}|here>."
        notifier.ping message
      end

      if config_attr[:update]
        message = "Bug *\##{@bug.number}* was changed on project *#{@project.name}*. It is *#{@bug.status}* and its description was altered to:\n\n#{@bug.description} \n\nYou can access this bug clicking <#{project_bug_url(@project,@bug)}|here>."
        notifier.ping message
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:project_id, :description, :status)
    end
end
