class AssignmentComment < ApplicationRecord
  belongs_to :assignment

  validates :assignment, presence: true
  validates :comment, presence: true
end
