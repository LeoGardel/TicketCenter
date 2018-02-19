RSpec.describe "Bugs", type: :request do
  let(:persisted_user) { FactoryBot.create(:valid_user) }
  let!(:persisted_project) { FactoryBot.create(:valid_project) }
  let!(:persisted_bug) { FactoryBot.create(:valid_bug, user_status_id: persisted_user.id, project_id: persisted_project.id) }
  let!(:project_id) { persisted_project.id }
  let!(:bug_id) { persisted_bug.id }
  let(:valid_attributes) { FactoryBot.attributes_for(:another_valid_bug, user_status_id: persisted_user.id, project_id: persisted_project.id) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:bug_with_undefined_description, user_status_id: persisted_user.id, project_id: persisted_project.id) }
  before(:each) { sign_in persisted_user }

  # The stub below is to avoid tests to send messages on Slack
  before(:each) { allow_any_instance_of(BugsController).to receive(:send_slack_notification) }
  
  describe "GET /projects/:project_id/bugs" do
    it "fetches bugs" do
      get project_bugs_path(project_id)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET /projects/:project_id/bugs/:bug_id" do
    it "shows bug" do
      get project_bug_path(project_id, bug_id)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
  
  describe "POST /projects/:project_id/bugs" do
    it "with valid attributes, creates a Bug and redirects to the Bug's page" do
      get new_project_bug_path(project_id)
      expect(response).to render_template(:new)

      #post project_bugs_path(project_id), params: {:bug => valid_attributes}
      
      fill_in "project_name", with: Faker::Name.name
      fill_in "project_manager_id", with: persisted_user.id
      click_on "project_submit_action"
      
      expect(response).to redirect_to([assigns(:project), assigns(:bug)])
      expect(response).to have_http_status(:found)
      
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include("Bug was successfully created.")
    end
  
    it "with invalid attributes, shows errors at the form new" do
      get new_project_bug_path(project_id)
      expect(response).to render_template(:new)

      post project_bugs_path(project_id), params: {:bug => invalid_attributes}
      expect(response).to render_template(:new)
    end
  end
  
  describe "PATCH/PUT /projects/:project_id/bugs/:bug_id" do
    it "with valid attributes, updates a Bug and redirects to the Bug's page" do
      [:patch, :put].each do |method|
        get edit_project_bug_path(project_id, bug_id)
        expect(response).to render_template(:edit)
  
        process method, project_bug_path, params: {project_id: :project_id, id: :bug_id, :bug => valid_attributes}
        expect(response).to redirect_to([assigns(:project), assigns(:bug)])
        expect(response).to have_http_status(:found)
        
        follow_redirect!
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
        expect(response.body).to include("Bug was successfully updated.")
      end
    end
  
    it "with invalid attributes, shows errors at the form edit" do
      [:patch, :put].each do |method|
        get edit_project_bug_path(project_id, bug_id)
        expect(response).to render_template(:edit)
  
        process method, project_bug_path, params: {project_id: :project_id, id: :bug_id, :bug => invalid_attributes}
        expect(response).to render_template(:edit)
      end
    end
  end

end
