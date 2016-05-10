class Api::V1::TheftsController < ApplicationController
    respond_to :json
    
    def index
       render json: { error: "Sorry :( no thefts yet... Wait, that's actually a good thing.", status: :not_found }
    end
    
    def show
       respond_with Theft.(params[:id])
    end
    
end
