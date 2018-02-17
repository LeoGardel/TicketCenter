class Bug < ApplicationRecord
  before_create :set_number
  before_save :set_date_status, if: :status_changed?
  before_save :preserve_last_user_status, unless: :status_changed?

  # user_status is used to hold the last user who wrote in the status field
  belongs_to :user_status, class_name: 'User'
  belongs_to :project, dependent: :destroy
  enum status: [:active, :archived, :inactive]

  validates_presence_of :project, :description, :status, :user_status

  private
    # Method used to set the last moment which status was written
    def set_date_status
      self.date_status = DateTime.now
    end
    
    # Method used to keep the last user that wrote in the status field as the user_status
    def preserve_last_user_status
      self.restore_user_status_id!
    end

    # Method used to initialize the Bug number, which is an incremental sequence without repetitions FOR EACH PROJECT
    def set_number
      max_num = self.project.bugs.maximum(:number)
      self.number = max_num.nil? ? 1 : max_num + 1
    end
end
