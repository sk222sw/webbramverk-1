class Api::V1::CreatorController < ApplicationController
    skip_before_action :authenticate, only: [:index, :show]
end
