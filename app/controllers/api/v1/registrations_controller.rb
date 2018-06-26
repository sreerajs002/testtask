module Api
	module V1
		class RegistrationsController < ApiController
		   skip_before_action :verify_authenticity_token
		   skip_before_action :require_login!

         def create
            begin
               user = User.participants.find_or_initialize_by(email: params[:user][:email])
               if user.persisted? 
                  raise "Account already exists with the provided email."
               end
               unless user.update(user_create_params)
                  raise user.errors.full_messages.join(',')
               end
            rescue => e
               render json: {error: e}
            end
         end

         protected
         def user_create_params
            params.require('user').permit(:email, :password, :password_confirmation, :name, :role)
         end
		end
	end
end