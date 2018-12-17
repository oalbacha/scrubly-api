require 'rails_helper'

RSpec.describe Patient, type: :model do
# Association test
  # ensure Patient model has a 1:m relationship with the Appointment model
  it { should have_many(:appointments).dependent(:destroy) }
  # Validation tests
  # ensure columns first_name and phone are present before saving
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:phone) }
end
