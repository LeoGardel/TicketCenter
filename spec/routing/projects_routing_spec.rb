RSpec.describe ProjectsController, type: :routing do
  describe "routing" do

    it { should route(:get, "/projects").to(action: :index) }
    it { should route(:get, "/projects/1").to(action: :show, id: 1) }
    it { should route(:post, "/projects").to(action: :create) }
    it { should route(:get, "/projects/new").to(action: :new) }
    it { should route(:get, "/projects/1/edit").to(action: :edit, id: 1) }
    it { should route(:put, "/projects/1").to(action: :update, id: 1) }
    it { should route(:patch, "/projects/1").to(action: :update, id: 1) }
    it { should route(:delete, "/projects/1").to(action: :destroy, id: 1) }

  end
end
