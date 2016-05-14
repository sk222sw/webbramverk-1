class PositionSerializer < ActiveModel::Serializer
  attributes :id, :longitude, :latitude, :address
  
  def links
    
  end
  
end
