class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  include SubscriptionConcern

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts, dependent: :destroy
  has_many :contact_groups, dependent: :destroy
  has_many :contact_types, dependent: :destroy
  has_many :interactions, dependent: :destroy
  has_many :last_known_cities, dependent: :destroy
  has_many :last_known_countries, dependent: :destroy
  has_many :categories
  has_many :locations, class_name: 'Location', dependent: :destroy

  # STRIPE RELATED
  pay_customer stripe_attributes: :stripe_attributes

  def stripe_attributes(pay_customer)
    {
      address: {
        city: pay_customer.owner.city,
        country: pay_customer.owner.country
      },
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id 
      }
    }
  end

  has_one :pay_customer, as: :owner, class_name: 'Pay::Customer'

  def stripe_customer_id
    pay_customer&.processor_id
  end

  def stripe_customer
    @stripe_customer ||= Stripe::Customer.retrieve(stripe_customer_id)
  end

  def has_purchased_product?(product_name)
    return false unless stripe_customer_id.present?

    charges = Stripe::Charge.list(customer: stripe_customer_id)
    charges.data.any? do |charge|
      charge.description == product_name
    end
  end

  def billing_portal_url
    return nil unless stripe_customer_id.present?
    
    return_url = "http://localhost:3000/billing"  # Use http:// or https:// based on your setup
    
    Stripe::BillingPortal::Session.create({
      customer: stripe_customer_id,
      return_url: return_url,
    }).url
  end

  def has_active_subscription?(subscription_name)
    return false unless stripe_customer_id.present?

    subscriptions = Stripe::Subscription.list(customer: stripe_customer_id)
    subscriptions.data.any? do |subscription|
      subscription.items.data.any? do |item|
        item.price.product == subscription_name && subscription.status == 'active'
      end
    end
  end

  def lifetime?
    has_purchased_product?("Lifetime Subscription")
  end

end
