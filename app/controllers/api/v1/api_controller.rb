class Api::V1::ApiController < ApplicationController
    before_action :require_login!
    helper_method :person_signed_in?, :current_person
    respond_to :xml, :json

    def user_signed_in?
        current_person.present?
    end

    def require_login!
        return true if authenticate_token
        render json: { errors: [ { detail: "Access denied" } ] }, status: 401
    end

    def current_person
     @_current_user ||= authenticate_token
    end

    def authenticate_token
        User.find_by(auth_token: request.headers["token"])
    end
end
