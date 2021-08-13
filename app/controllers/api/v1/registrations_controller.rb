module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      # before_action :sign_up_params

      private

      def sign_up_params
        params.require(:user).permit(:email, :gender, :password, :password_confirmation)
      end
    end
  end
end
