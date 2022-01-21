class CommentSerializer < ActiveModel::Serializer
  attributes :id, :children, :created_at
end