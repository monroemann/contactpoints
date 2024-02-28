class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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


end
