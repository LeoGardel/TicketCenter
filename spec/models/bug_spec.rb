require 'rails_helper'

RSpec.describe Bug, type: :model do

  #respond_to validations
  it { should respond_to(:project_id) }
  it { should respond_to(:project) }
  it { should respond_to(:description) }
  it { should respond_to(:status) }
  it { should respond_to(:user_status_id) }
  it { should respond_to(:user_status) }
  it { should respond_to(:date_status) }
  it { should respond_to(:number) }

  #presence validations
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:user_status) }

  #association validations
  it { should belong_to(:user_status).class_name('User')}
  it { should belong_to(:project).dependent(:destroy) }

  #value validations
  it { should define_enum_for(:status).with_values([:active, :archived, :inactive])}
  it "should be accepted with valid attributes" do
    valid_bug = FactoryBot.build(:valid_bug)
    expect(valid_bug).to be_valid
  end

end
