require 'rails_helper'

RSpec.describe User, type: :model do

  #respond_to validations
  it { should respond_to(:name) }
  it { should respond_to(:date_of_birth) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:current_password) }
  it { should respond_to(:remember_me) }

  #presence validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  
  #uniqueness validations
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_uniqueness_of(:email).case_insensitive }
  
  #association validations
  it { should have_many(:decided_bugs).class_name('Bug').with_foreign_key('user_status_id') }
  it { should have_many(:managed_projects).class_name('Project').with_foreign_key('manager_id') }

  #value validations
  it "should be accepted with valid attributes" do
    valid_user = FactoryBot.build(:valid_user)
    expect(valid_user).to be_valid
  end
  
end
