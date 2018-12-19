require 'rails_helper'

# test suite for User model
RSpec.describe User, type: :model do
  # Association test
  # Ensure User model has a 1:m relationship with the Patient model
  it {should have_many(:patients).with_foreign_key('provider_id')}

  # validation test
  # ensure name, email and password_digest are present before save
  it {should validate_presence_of(:name) }
  it {should  validate_presence_of(:email) }
  it {should  validate_presence_of(:password_digest) }
end
