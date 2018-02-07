class Bug < ApplicationRecord
  belongs_to :project
  enum status: [:active, :archived, :inactive]
end
