class Tag < ActiveRecord::Base
    has_and_belongs_to_many :thefts
    
    validates   :name, 
                :presence => {:message => "Please provide a tag name" }

end
