class CommentSerializer
  include JSONAPI::Serializer

  attributes :id, :content

  attribute :commenter_name do |object|
    object.user.name
  end
end
