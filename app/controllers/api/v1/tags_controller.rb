class Api::V1::TagsController < ApplicationController
    respond_to :json
    
    def create
        tag = Tag.new(tag_params)
        tag.save
    end
   
    def index
        elsif params[:theft_id]
            theft = Theft.find(params[:theft_id])
            respond_with theft.tags
        else
            respond_with Tag.all
        end
    end
    
    def show
        respond_with Tag.find(params[:id])
    end
   
        private
            def tag_params
                json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
                json_params.require(:tag).permit(:name)
            end
end
