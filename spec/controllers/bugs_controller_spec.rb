require 'rails_helper'

RSpec.describe BugsController, type: :controller do
  let(:persisted_user) { FactoryBot.create(:valid_user) }
  let!(:persisted_project) { FactoryBot.create(:valid_project) }
  let!(:persisted_bug) { FactoryBot.create(:valid_bug, user_status_id: persisted_user.id, project_id: persisted_project.id) }
  let(:valid_attributes) { FactoryBot.attributes_for(:another_valid_bug, user_status_id: persisted_user.id, project_id: persisted_project.id) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:bug_with_undefined_description, user_status_id: persisted_user.id, project_id: persisted_project.id) }
  
  # The stub below is to avoid tests to send messages on Slack
  before(:each) { allow_any_instance_of(BugsController).to receive(:send_slack_notification) }

  context "when unauthenticated" do
    before(:each) { sign_in nil }
    
    it "blocks access to index" do
      get :index, params: {project_id: persisted_project.id}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to show" do
      get :show, params: {project_id: persisted_project.id, id: persisted_bug.to_param}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to new" do
      get :new, params: {project_id: persisted_project.id}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to edit" do
      get :edit, params: {project_id: persisted_project.id, id: persisted_bug.to_param}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to create" do
      post :create, params: {project_id: persisted_project.id, bug: valid_attributes}
      expect(response).to redirect_to(new_user_session_path)
    end
    it "blocks access to update" do
      put :update, params: {project_id: persisted_project.id, id: persisted_bug.to_param, bug: valid_attributes}
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  
  context "when authenticated" do
    before(:each) { sign_in persisted_user }
    
    describe "GET #index" do
      it "returns a success response" do
        get :index, params: {project_id: persisted_project.id}
        expect(response).to be_success
      end
    end
  
    describe "GET #show" do
      it "returns a success response" do
        get :show, params: {project_id: persisted_project.id, id: persisted_bug.to_param}
        expect(response).to be_success
      end
    end
  
    describe "GET #new" do
      it "returns a success response" do
        get :new, params: {project_id: persisted_project.id}
        expect(response).to be_success
      end
    end
  
    describe "GET #edit" do
      it "returns a success response" do
        get :edit, params: {project_id: persisted_project.id, id: persisted_bug.to_param}
        expect(response).to be_success
      end
    end
  
    describe "POST #create" do
      context "with valid params" do
        it "creates a new Bug" do
          expect {
            post :create, params: {project_id: persisted_project.id, bug: valid_attributes}
          }.to change(Bug, :count).by(1)
        end
  
        it "redirects to the created bug" do
          post :create, params: {project_id: persisted_project.id, bug: valid_attributes}
          expect(response).to redirect_to([persisted_project, Bug.last])
        end
      end
  
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {project_id: persisted_project.id, bug: invalid_attributes}
          expect(response).to be_success
        end
      end
    end
  
    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested bug" do
          put :update, params: {project_id: persisted_project.id, id: persisted_bug.to_param, bug: valid_attributes}
          persisted_bug.reload
          valid_attributes.each_pair do |key, value|
            expect(persisted_bug[key]).to eq(value.class == Symbol ? value.to_s : value)
          end
        end
  
        it "redirects to the bug" do
          put :update, params: {project_id: persisted_project.id, id: persisted_bug.to_param, bug: valid_attributes}
          expect(response).to redirect_to([persisted_project, persisted_bug])
        end
      end
  
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {project_id: persisted_project.id, id: persisted_bug.to_param, bug: invalid_attributes}
          expect(response).to be_success
        end
      end
    end
  end
end
