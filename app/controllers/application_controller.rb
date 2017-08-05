class ApplicationController < ActionController::Base
	include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	# Devise Authenticate user
	before_action :authenticate_user!, except: [:index, :about]

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	def user_not_authorized
		flash[:alert] = "You are not authorized to perform this action."
		redirect_to(request.referrer || root_path)
	end
end
