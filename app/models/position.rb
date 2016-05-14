class Position < ActiveRecord::Base
    has_many :thefts

    after_validation :get_address
    
    validates :longitude, presence: true 
    validates :latitude, presence: true

    reverse_geocoded_by :latitude, :longitude

    validates_numericality_of :longitude, only_float: true
    
    def get_nearby_addresses
        Position.near(self.latitude.to_s + "," + self.longitude.to_s)
    end
    
    def get_address
        lat = self.latitude
        lon = self.longitude
        query = "#{lat},#{lon}"
        result = Geocoder.search(query).first
        if result.present?
            self.address = result.address
        end
    end

end
