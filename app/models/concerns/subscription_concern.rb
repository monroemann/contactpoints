module SubscriptionConcern
	extend ActiveSupport::Concern

	included do
		def check_subscription_status
		  
		  subscription = payment_processor&.subscription&.processor_subscription

		  return if subscription.nil?

		  update(
		    subscription_status: subscription.status,
		    subscription_end_date: Time.at(subscription.current_period_end),
		    subscription_start_date: Time.at(subscription.current_period_start)
		  )

		  Rails.logger.info "***********************************************************************
		  ********************************************************************
		  **********************************************
		  ******************************Subscription end date updated to: #{subscription_end_date}"

		  
		end


		def active_subscription?

		  check_subscription_status

		  return false if subscription_end_date.nil?
		  
		  subscription_end_date >= Time.now
		end

	end

end
