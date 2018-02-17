require 'rails_helper'

RSpec.describe Project, type: :model do

  #respond_to validations
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:start_date) }
  it { should respond_to(:manager) }
  it { should respond_to(:manager_id) }
  it { should respond_to(:end_date) }

  #presence validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:manager) }
  
  #uniqueness validations
  it { should validate_uniqueness_of(:name).case_insensitive }
  
  #association validations
  it { should have_many(:bugs).dependent(:destroy) }
  it { should belong_to(:manager).class_name('User') }
  
  #value validations
  it "should be accepted when start_date is before end_date" do
    valid_project = FactoryBot.build(:valid_project)
    expect(valid_project).to be_valid
  end
  it "should be accepted when start_date is equal to end_date" do
    another_valid_project = FactoryBot.build(:another_valid_project)
    expect(another_valid_project).to be_valid
  end
  it "should not be accepted when start_date after end_date" do
    project_with_invalid_dates = FactoryBot.build(:project_with_invalid_dates)
    expect(project_with_invalid_dates).to be_invalid
  end
  
end
