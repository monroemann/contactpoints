class MembersController < ApplicationController

#   Can potentially delete all this, because it's handled in the interactions_controller.
  
#   before_action :authenticate_user!
#   before_action :check_subscription_status

#   def dashboard
#   end

#   private

#   def check_subscription_status
#     unless current_user.active_subscription?
#       redirect_to checkout_path, alert: "You have exceed the free plan and must upgrade."
#     end
#   end
# end
