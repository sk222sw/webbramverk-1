class Theft < ActiveRecord::Base
    belongs_to :creator
    
    validates   :description, 
                :presence => {:message => "Please provide a description" }
                
    validates   :time, 
                :presence => {:message => "Please provide a proper date (time optional) YYYY-MM-DD [HH:MM]" }

end
