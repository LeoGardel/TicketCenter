class Project < ApplicationRecord
	has_many :bugs, dependent: :destroy
	has_and_belongs_to_many :users
	belongs_to :manager, class_name: 'User'
end
