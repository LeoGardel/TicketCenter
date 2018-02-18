RSpec.describe BugsController, type: :routing do
  describe "routing" do

    it { should route(:get, "/projects/1/bugs").to(action: :index, project_id: 1) }
    it { should route(:get, "/projects/1/bugs/2").to(action: :show, project_id: 1, id: 2) }
    it { should route(:post, "/projects/1/bugs").to(action: :create, project_id: 1) }
    it { should route(:get, "/projects/1/bugs/new").to(action: :new, project_id: 1) }
    it { should route(:get, "/projects/1/bugs/2/edit").to(action: :edit, project_id: 1, id: 2) }
    it { should route(:put, "/projects/1/bugs/2").to(action: :update, project_id: 1, id: 2) }
    it { should route(:patch, "/projects/1/bugs/2").to(action: :update, project_id: 1, id: 2) }

  end
end
