class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :managed_projects, foreign_key: "manager_id", class_name: "Project"
  has_many :decided_bugs, foreign_key: "user_status_id", class_name: "Bug"
  
  validates_presence_of :name, :email
  validates_uniqueness_of :name, :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false
end
