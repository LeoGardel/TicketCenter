require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:persisted_user) { FactoryBot.create(:valid_user) }
  let!(:persisted_project) { FactoryBot.create(:another_valid_project) }
  let(:valid_attributes) { FactoryBot.attributes_for(:valid_project, manager_id: persisted_user.id) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:project_with_invalid_dates, manager: persisted_user.id) }

  context "when unauthenticated" do
    before(:each) { sign_in nil }
    
    it "allows access to index" do
      get :index
      expect(response).to be_success
    end
    it "blocks access to show" do
      get :show, params: {id: persisted_project.to_param}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to new" do
      get :new, params: {}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to edit" do
      get :edit, params: {id: persisted_project.to_param}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to create" do
      post :create, params: {project: valid_attributes}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to update" do
      put :update, params: {id: persisted_project.to_param, project: valid_attributes}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to destroy" do
      delete :destroy, params: {id: persisted_project.to_param}
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  
  context "when authenticated" do
    before(:each) { sign_in }
    
    describe "GET #index" do
      it "returns a success response" do
        get :index, params: {}
        expect(response).to be_success
      end
    end
  
    describe "GET #show" do
      it "returns a success response" do
        get :show, params: {id: persisted_project.to_param}
        expect(response).to be_success
      end
    end
  
    describe "GET #new" do
      it "returns a success response" do
        get :new, params: {}
        expect(response).to be_success
      end
    end
  
    describe "GET #edit" do
      it "returns a success response" do
        get :edit, params: {id: persisted_project.to_param}
        expect(response).to be_success
      end
    end
  
    describe "POST #create" do
      context "with valid params" do
        it "creates a new Project" do
          expect {
            post :create, params: {project: valid_attributes}
          }.to change(Project, :count).by(1)
        end
  
        it "redirects to the created project" do
          post :create, params: {project: valid_attributes}
          expect(response).to redirect_to(Project.last)
        end
      end
  
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {project: invalid_attributes}
          expect(response).to be_success
        end
      end
    end
  
    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested project" do
          put :update, params: {id: persisted_project.to_param, project: valid_attributes}
          persisted_project.reload
          valid_attributes.each_pair do |key, value|
            expect(persisted_project[key]).to eq(value.class == Symbol ? value.to_s : value)
          end
        end
  
        it "redirects to the project" do
          put :update, params: {id: persisted_project.to_param, project: valid_attributes}
          expect(response).to redirect_to(persisted_project)
        end
      end
  
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {id: persisted_project.to_param, project: invalid_attributes}
          expect(response).to be_success
        end
      end
    end
  
    describe "DELETE #destroy" do
      it "destroys the requested project" do
        expect {
          delete :destroy, params: {id: persisted_project.to_param}
        }.to change(Project, :count).by(-1)
      end
  
      it "redirects to the projects list" do
        delete :destroy, params: {id: persisted_project.to_param}
        expect(response).to redirect_to(projects_url)
      end
    end
  end
end
