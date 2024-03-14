class ApplicationController < ActionController::Base

	before_action :authenticate_user!, except: :index
	before_action :set_query
	before_action :set_portal_session, except: :index

	include Pagy::Backend

	def set_query
		@query = Contact.ransack(params[:q])
	end

	def set_portal_session
	  if current_user
	    @portal_session = current_user.payment_processor.billing_portal
	  end
	end

end
