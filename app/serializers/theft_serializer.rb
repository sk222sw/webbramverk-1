class TheftSerializer < ActiveModel::Serializer
    has_one :creator
    has_one :position
    has_many :tags
    
    def links
       { 
           self:        api_theft_path(object.id),
           creator:     api_creator_path(object.id),
           position:    api_theft_positions_path(object.id),
           tags:        api_theft_tags_path(object.id)
       } 
    end
    
    attributes :id, :description, :time, :links
end
