require 'rails_helper'

RSpec.describe Appointment, type: :model do
  # Association test
  # ensure an appointment record belongs to a single patient record
  it { should belong_to(:patient) }
  # Validation test
  # ensure column title is present before saving
  it { should validate_presence_of(:title) }
end
