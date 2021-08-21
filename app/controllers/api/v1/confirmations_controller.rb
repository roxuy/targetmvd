module Api
  module V1
    class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
      def show
        self.resource = resource_class.confirm_by_token(params[:confirmation_token])
        yield resource if block_given?

        if resource.errors.empty?
          set_flash_message!(:notice, :confirmed)
          render json: { 'message': 'user has been confirmed' }, status: :accepted
        else
          render json: { 'error': 'error at confirmation' }, status: :unprocessable_entity
        end
      end
    end
  end
end
