# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize

  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: %i[google_oauth2 github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  enumerize :role, in: %i[consumer admin]

  def admin?
    role == "admin"
  end

  def to_s
    email
  end

  after_create do
    customer = Stripe::Customer.create(email:)
    update(stripe_customer_id: customer.id)
  end
end
