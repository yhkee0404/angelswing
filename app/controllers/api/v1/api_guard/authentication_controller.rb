module Api::V1::ApiGuard
  class AuthenticationController < ApiGuard::AuthenticationController
    include ViewPathSync, LookupUsers
    before_action :find_resource, only: [:create]
    before_action :authenticate_resource, only: [:destroy]
    wrap_parameters false

    def create
      if resource.authenticate(@params[:password])
        create_token_and_set_header(resource, resource_name)
        @user = resource
        render :show, status: :created
      else
        # render_error(422, message: I18n.t('api_guard.authentication.invalid_login_credentials'))
        render '/message', locals: {message: I18n.t('api_guard.authentication.invalid_login_credentials')}, status: :unprocessable_entity
      end
    end

    # def destroy
    #   blacklist_token
    #   render_success(message: I18n.t('api_guard.authentication.signed_out'))
    # end

    private

    def find_resource
      @params = params[:auth]
      self.resource = resource_class.find_by(email: @params[:email].downcase.strip) if @params[:email].present?
      # render_error(422, message: I18n.t('api_guard.authentication.invalid_login_credentials')) unless resource
      render '/message', locals: {message: I18n.t('api_guard.authentication.invalid_login_credentials')}, status: :unprocessable_entity unless resource
    end
  end
end
