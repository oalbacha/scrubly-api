class PatientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :created_at, :updated_at

  # model association
  has_many :appointments
end
