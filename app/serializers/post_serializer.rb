class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description

  attribute :author_name do |object|
    object.user.name
  end

  attribute :comments do |object|
    object.comments.map {|comment| CommentSerializer.new(comment).serializable_hash }
  end

end
