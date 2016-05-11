class Position < ActiveRecord::Base

    has_many :thefts
    
    validates :longitude, presence: true
    validates :latitude, presence: true

end
