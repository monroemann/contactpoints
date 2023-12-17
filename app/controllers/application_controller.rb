class ApplicationController < ActionController::Base

	before_action :authenticate_user!, except: :index
	before_action :set_query

	def set_query
		@query = Contact.ransack(params[:q])
	end

end
