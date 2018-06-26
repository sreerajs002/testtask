module Api
  module V1
    class SessionsController < ApiController
      before_action :authenticate_user!, :except => [:create]
      skip_before_action :verify_authenticity_token
      skip_before_action :require_login!
      respond_to :json

      def create
        resource = User.participants.find_for_database_authentication(:email => params[:user][:email])
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:user][:password])
          sign_in(resource)
        #   resource.ensure_authentication_token!

          render json:
             {result: [{id: resource.id, token: resource.auth_token}]}
          return
        else
        end
        invalid_login_attempt
      end

      def destroy
        act_resource_name = resource_name.to_s.split("_").last.to_sym
        sign_out(act_resource_name)
        render :json => {resource_name: act_resource_name  }.to_json, :status => :ok
      end

      protected
      def ensure_params_exist
        return unless params[:user].blank?
        render :json=>{:message=>"missing user parameter"}, :status=>422
      end

      def invalid_login_attempt
        render json: {result: ["Invalid login credentials. Please try again."], status: 401}
      end
    end
  end
end