module Api
  module V1
    class TopicsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def index
        @topics = Topic.all
      end
    end
  end
end
