module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      private

      def resource_params
        params.require(:user).permit(:email, :password)
      end

      def render_create_success
        render json: @resource.as_json
      end
    end
  end
end
