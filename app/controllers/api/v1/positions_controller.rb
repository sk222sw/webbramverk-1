class Api::V1::PositionsController < ApplicationController
    respond_to :json
    
    def index
        if params[:theft_id]
            theft = Theft.find(params[:theft_id])
            pos_id = theft.position_id
            respond_with Position.find(pos_id)
        else
           respond_with Position.all 
        end
    end
    
    def show
        respond_with Position.find(params[:id])
    end
    
    def create
        position = Position.create(position_params)
        position.save
    end
    
    private
    
    def position_params
       params.require(:position).permit(:longitude, :latitude) 
    end
    
end
