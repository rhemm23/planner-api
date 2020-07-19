class AssignmentSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :due_date

  def due_date
    object.due_date.to_i
  end
end
