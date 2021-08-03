module V1
  class  Api::V1::RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :sign_up_params

    private
    def sign_up_params
      params.require(:user).permit(:email, :gender, :password, :password_confirmation)
    end
  end
end
