class Theft < ActiveRecord::Base
    belongs_to :creator
    belongs_to :position, :dependent => :destroy
    has_and_belongs_to_many :tags
    
    validates   :description, 
                :presence => {:message => "Please provide a description" }
                
    validates   :time, 
                :presence => {:message => "Please provide a proper date (time optional) YYYY-MM-DD HH:MM" }
end
