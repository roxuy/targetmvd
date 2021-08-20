module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      before_action :authenticate_api_v1_user!
      skip_before_action :authenticate_api_v1_user!, only: [:create]

      private

      def sign_up_params
        params.require(:user).permit(:email, :gender, :password, :password_confirmation)
      end
    end
  end
end
