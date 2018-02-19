RSpec.describe "Projects", type: :request do
  let(:persisted_user) { FactoryBot.create(:valid_user) }
  let!(:persisted_project) { FactoryBot.create(:valid_project) }
  let!(:project_id) { persisted_project.id }
  let(:valid_attributes) { FactoryBot.attributes_for(:another_valid_project, manager_id: persisted_user.id) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:project_with_invalid_dates, manager_id: persisted_user.id) }
  before(:each) { sign_in persisted_user }

  describe "GET /projects" do
    it "fetches projects" do
      get projects_path
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET /projects/:project_id" do
    it "shows project" do
      get project_path(project_id)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
  
  describe "POST /projects" do
    it "with valid attributes, creates a Project and redirects to the Project's page" do
      get new_project_path
      expect(response).to render_template(:new)

      post projects_path, params: {:project => valid_attributes}
      expect(response).to redirect_to(assigns(:project))
      expect(response).to have_http_status(:found)
      
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include("Project was successfully created.")
    end
  
    it "with invalid attributes, shows errors at the form new" do
      get new_project_path
      expect(response).to render_template(:new)

      post projects_path, params: {:project => invalid_attributes}
      expect(response).to render_template(:new)
    end
  end
  
  describe "PATCH/PUT /projects/:project_id" do
    it "with valid attributes, updates a Project and redirects to the Project's page" do
      [:patch, :put].each do |method|
        get edit_project_path(project_id)
        expect(response).to render_template(:edit)
  
        process method, project_path, params: {id: :project_id, :project => valid_attributes}
        expect(response).to redirect_to(assigns(:project))
        expect(response).to have_http_status(:found)
        
        follow_redirect!
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
        expect(response.body).to include("Project was successfully updated.")
      end
    end
  
    it "with invalid attributes, shows errors at the form edit" do
      [:patch, :put].each do |method|
        get edit_project_path(project_id)
        expect(response).to render_template(:edit)
  
        process method, project_path, params: {id: :project_id, :project => invalid_attributes}
        expect(response).to render_template(:edit)
      end
    end
  end
  
  describe "DELETE /projects/:project_id" do
    it "deletes a Project and redirects to Projects list" do
      delete project_path(project_id)
      expect(response).to redirect_to(projects_url)
      expect(response).to have_http_status(:found)
      
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Project was successfully destroyed.")
    end
  end

end
