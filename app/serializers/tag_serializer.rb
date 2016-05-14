class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :links
  
  def links
    { 
        self: api_tag_path(object.id) 
    }
  end
  
end
