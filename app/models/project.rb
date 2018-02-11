class Project < ApplicationRecord
  has_many :bugs, dependent: :destroy
  has_and_belongs_to_many :users
  belongs_to :manager, class_name: 'User'

  validates_presence_of :name, :manager
  validates :end_date, date: { after_or_equal_to: :start_date, allow_blank: true }
end
