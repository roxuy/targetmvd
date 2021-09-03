module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def create
        target = Target.new(target_params)
        target.user = current_api_v1_user

        if target.save
          targets = search(target.radius, target.latitude, target.longitude,
                           target.topic_id, target.user)

          conversations = targets.map do |t|
            create_conversation(target.user,
                                User.find(t.user.id), target.topic)
          end

          matched_users = targets.map(&:user).uniq

          @response = { target: target, conversations: conversations, matched_users: matched_users }
          render status: :created
        else
          render json: target.errors, status: :unprocessable_entity
        end
      end

      def target_params
        params.require(:target).permit(:title, :topic_id, :latitude, :longitude, :radius)
      end

      def search(radius, latitude, longitude, topic_id, current_user)
        Target.within(
          radius,
          origin: [
            latitude,
            longitude
          ]
        ).where(topic_id: topic_id).where.not(user_id: current_user)
      end

      def create_conversation(user, user_match, topic)
        Conversation.create(user1: user, user2: user_match, topic: topic)
      end
    end
  end
end
