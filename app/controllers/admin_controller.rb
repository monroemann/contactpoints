
# app/controllers/admin_controller.rb

class AdminController < ApplicationController

  def index
    @users = User.all
    @subscription_statuses = {}

		@users.each do |user|
		  @subscription_statuses[user.id] = []

		  if user.has_purchased_product?("Lifetime Subscription")
		    @subscription_statuses[user.id] << "Lifetime"
		  end

		  if user.has_active_subscription?("Annual Subscription")
		    @subscription_statuses[user.id] << "Annual"
		  end

		  if user.has_active_subscription?("Monthly Subscription")
		    @subscription_statuses[user.id] << "Monthly"
		  end

		  if user.vip?
		    @subscription_statuses[user.id] << "VIP"
		  end

		  if user.admin?
		    @subscription_statuses[user.id] << "Admin"
		  end

		  if @subscription_statuses[user.id].empty?
		    @subscription_statuses[user.id] << "Free"
		  end
		end

  end

end
