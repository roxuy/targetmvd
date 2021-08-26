module Api
  module V1
    class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
      def show
        self.resource = resource_class.confirm_by_token(params[:confirmation_token])

        if resource.errors.empty?
          render json: { success: true,
                         message: I18n.t('devise.confirmations.confirmed') },
                 status: :accepted
        else
          render json: { success: false,
                         message: I18n.t('errors.messages.error_confirmation') },
                 status: :unprocessable_entity
        end
      end
    end
  end
end
