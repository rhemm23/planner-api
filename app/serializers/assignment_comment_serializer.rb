class AssignmentCommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :created_at

  def created_at
    object.created_at.to_i
  end
end
