class ApplicationController < ActionController::Base
	rescue_from CanCan::AccessDenied do |exception|
	  redirect_to root_url, flash: {error: "You are anothorized to access it"}
	end
end
