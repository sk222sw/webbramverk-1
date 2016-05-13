class Api::V1::CreatorsController < ApplicationController
    skip_before_action :authenticate, only: [:index, :show]
    respond_to :json
    
    def index
        respond_with Creator.all 
    end
    
    def show
       respond_with Creator.find(params[:id])
    end
end
