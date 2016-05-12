class Api::V1::TagsController < ApplicationController
    
    def create
        tag = Tag.new(tag_params)
        tag.save
    end
   
        private
            def tag_params
                json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
                json_params.require(:tag).permit(:name)
            end
end
