class CheckoutsController < ApplicationController

	before_action :authenticate_user!

	def show
		current_user.set_payment_processor :stripe
		current_user.payment_processor.customer

		@lifetime_checkout_session = current_user
			.payment_processor
			.checkout(
				mode: 'payment',
				line_items: 'price_1Ou2v6FcW3sxtEaBYqI4QdVg',
				success_url: checkout_success_url
			)

		@annual_checkout_session = current_user
			.payment_processor
			.checkout(
				mode: 'subscription',
				line_items: 'price_1OuJRxFcW3sxtEaBp4GGyxjh',
				success_url: checkout_success_url
			)

		@monthly_checkout_session = current_user
			.payment_processor
			.checkout(
				mode: 'subscription',
				line_items: 'price_1OuJLXFcW3sxtEaBseGXerkH',
				success_url: checkout_success_url
			)

	end

	def success
		@session = Stripe::Checkout::Session.retrieve(params[:session_id])
		@line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])

	  # Assuming there's only one line item in the session for simplicity
	  line_item = @line_items.data.first

	  # Retrieve the product object associated with the line item
	  product_id = line_item.price.product
	  @product = Stripe::Product.retrieve(product_id)

	  # Now @product contains the product object, and you can print its name
	  @product_name = @product.name
	end

	def failure
	end

  def billing
  end


end
