class Theft < ActiveRecord::Base

    validates   :description, 
                :presence => {:message => "Please provide a description" }
                
    validates   :time, 
                :presence => {:message => "Please provide a proper date (time optional) YYYY-MM-DD [HH:MM]" }

end
