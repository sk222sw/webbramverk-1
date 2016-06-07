class Api::V1::TagsController < Api::V1::ApiBaseController
    respond_to :json
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate, only: [:index, :show]
    
    rescue_from ActiveRecord::RecordNotFound, :with => :resource_not_found
    ERROR_RESOURCE_NOT_FOUND = { error: "No resource with the provided ID could be found." }
    
    before_action :pagination_params
    
    def create
        tag = Tag.new(tag_params)
        tag.save
    end
   
    def index
        if params[:theft_id]
            theft = Theft.find(params[:theft_id])
            respond_with theft.tags
        else
            respond_with Tag.all
        end
    end
    
    def show
        tag = Tag.find(params[:id])
        
        if params[:thefts]
            thefts = tag.thefts
            100.times { puts thefts }
            response = { offset: @offset, limit: @limit, tag: tag, thefts: thefts}
            respond_with response
        else
            respond_with Tag.find(params[:id])
        end
        
    end
   
        private
            def tag_params
                json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
                json_params.require(:tag).permit(:name)
            end
            
        def resource_not_found
            render json: ERROR_RESOURCE_NOT_FOUND, status: 404
        end        
end
