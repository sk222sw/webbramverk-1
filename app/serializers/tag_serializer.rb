class TagSerializer < ActiveModel::Serializer
  attributes :id, :name
  
  def links
    { self: tag_path(object.id) }
  end
  
end
