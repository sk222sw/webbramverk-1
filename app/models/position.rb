class Position < ActiveRecord::Base

    has_many :thefts
    
    validates :longitude, presence: true 
    validates :latitude, presence: true

    validates_numericality_of :longitude, only_float: true

end
