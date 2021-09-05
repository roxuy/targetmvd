module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def create
        target = Target.new(target_params)
        target.user = current_api_v1_user

        if target.save
          @response = prepare_response(target)
          render status: :created
        else
          render json: target.errors, status: :unprocessable_entity
        end
      end

      def target_params
        params.require(:target).permit(:title, :topic_id, :latitude, :longitude, :radius)
      end

      def prepare_response(target)
        targets = search_targets(target.radius, target.latitude, target.longitude,
                                 target.topic_id, target.user)

        conversations = create_conversations(targets, target)

        matched_users = targets.map(&:user).uniq

        { target: target, conversations: conversations, matched_users: matched_users }
      end

      def search_targets(radius, latitude, longitude, topic_id, current_user)
        Target.within(
          radius,
          origin: [
            latitude,
            longitude
          ]
        ).where(topic_id: topic_id).where.not(user_id: current_user)
      end

      def create_conversations(targets, target)
        targets.map do |t|
          Conversation.create(user1: target.user, user2: User.find(t.user.id), topic: target.topic)
        end
      end
    end
  end
end
