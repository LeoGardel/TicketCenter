class Project < ApplicationRecord
  has_many :bugs, dependent: :destroy
  belongs_to :manager, class_name: 'User'

  validates_presence_of :name, :manager
  validates_uniqueness_of :name, :case_sensitive => false
  validates :end_date, date: { after_or_equal_to: :start_date, allow_blank: true }
end
