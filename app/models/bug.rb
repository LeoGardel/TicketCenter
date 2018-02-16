class Bug < ApplicationRecord
  before_validation :set_number, on: :create
  before_validation :set_status_audit

  belongs_to :project
  belongs_to :user_status, class_name: 'User'
  enum status: [:active, :archived, :inactive]

  validates_presence_of :project, :number, :description, :status, :user_status_id, :date_status
  validates :number, uniqueness: { scope: :project }
  validates :date_status, date: { before_or_equal_to: Proc.new { Time.now } }

  private
    def set_status_audit
      self.date_status = DateTime.now
    end

    def set_number
      max_num = self.project.bugs.maximum(:number)
      self.number = max_num.nil? ? 1 : max_num + 1
    end
end
