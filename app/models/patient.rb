class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  belongs_to :provider, class_name: "User", foreign_key: "provider_id", optional: true
  validates_presence_of :first_name, :phone
end
