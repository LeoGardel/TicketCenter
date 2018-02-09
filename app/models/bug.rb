class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user_status, class_name: 'User'
  enum status: [:active, :archived, :inactive]

  validates_presence_of :project, :number, :description, :status, :user_status_id, :date_status
  validates :number, uniqueness: { scope: :project }
  validates :date_status, date: { before_or_equal_to: Proc.new { Time.now } }
end
