module Api
  module V1
    class TopicController < ApplicationController
      #before_action :authenticate_api_v1_user!

      def index
        render json: Topic.all
      end
    end
  end
end
