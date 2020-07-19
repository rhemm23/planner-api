class Assignment < ApplicationRecord
  belongs_to :course
  has_many :assignment_comments
  
  validates :due_date, presence: true
  validates :course, presence: true
  validates :title, presence: true
end
