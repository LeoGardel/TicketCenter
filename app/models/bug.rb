class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user_status, class_name: 'User'
  enum status: [:active, :archived, :inactive]
end
