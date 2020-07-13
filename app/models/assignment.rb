class Assignment < ApplicationRecord
  belongs_to :course
  has_many :assignment_comments
end
