require 'rails_helper'

RSpec.describe Bug, type: :model do

  context "respond_to_validations" do
    it { should respond_to(:project_id) }
    it { should respond_to(:project) }
    it { should respond_to(:description) }
    it { should respond_to(:status) }
    it { should respond_to(:user_status_id) }
    it { should respond_to(:user_status) }
    it { should respond_to(:date_status) }
    it { should respond_to(:number) }
  end

  context "presence_validations" do
    subject { FactoryBot.build(:valid_bug) }
    
    it { should validate_presence_of(:project) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:user_status_id) }
    it { should validate_presence_of(:date_status) }
    it { should validate_presence_of(:number) }
  end

  context "uniqueness_validations" do
    subject { FactoryBot.build(:valid_bug) }

    it { should validate_uniqueness_of(:number).scoped_to(:project) }
    it { should_not validate_uniqueness_of(:project_id) }
    it { should_not validate_uniqueness_of(:project) }
    it { should_not validate_uniqueness_of(:description) }
    it { should_not validate_uniqueness_of(:status) }
    it { should_not validate_uniqueness_of(:user_status_id) }
    it { should_not validate_uniqueness_of(:user_status) }
    it { should_not validate_uniqueness_of(:date_status) }
  end

  context "associations" do
    it { should belong_to(:user_status).class_name('User')}
    it { should belong_to(:project) }
  end

  context "value_validations" do

    it { should define_enum_for(:status).with_values([:active, :archived, :inactive])}

    it "should accept valid bug" do
      valid_bug = FactoryBot.build(:valid_bug)
      expect(valid_bug).to be_valid
    end

    it "should not accept bug with date_status in the future" do
      invalid_bug = FactoryBot.build(:valid_bug, date_status: (Time.now + 60))
      expect(invalid_bug).to be_invalid
    end
  end

end
