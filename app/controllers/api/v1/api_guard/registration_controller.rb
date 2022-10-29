module Api::V1::ApiGuard
  class RegistrationController < ApiGuard::RegistrationController
    include ViewPathSync, LookupUsers
    before_action :authenticate_resource, only: [:destroy]
    wrap_parameters false

    def create
      init_resource(sign_up_params)
      if resource.save
        create_token_and_set_header(resource, resource_name)
        @user = resource
        render :show, status: :created
      else
        head :unprocessable_entity
      end
    end

    # def destroy
    #   current_resource.destroy
    #   render_success(message: I18n.t('api_guard.registration.account_deleted'))
    # end

    private
    
    def sign_up_params
      params.permit(:first_name, :last_name, :email, :password, :country)
    end
  end
end
