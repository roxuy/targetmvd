module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def create
        target = Target.new(target_params)
        target.user = current_api_v1_user

        if target.save
          @response = TargetMatcherService.new(target).find_matches
          render status: :created
        else
          render json: target.errors, status: :unprocessable_entity
        end
      end

      def target_params
        params.require(:target).permit(:title, :topic_id, :latitude, :longitude, :radius)
      end
    end
  end
end
