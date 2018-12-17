class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy

  validates_presence_of :first_name, :phone
end
