class Theft < ActiveRecord::Base
    belongs_to :creator
    belongs_to :position, :dependent => :destroy
    
    validates   :description, 
                :presence => {:message => "Please provide a description" }
                
    validates   :time, 
                :presence => {:message => "Please provide a proper date (time optional) YYYY-MM-DD [HH:MM]" }

end
