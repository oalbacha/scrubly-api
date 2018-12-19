class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # model association
  has_many :patients, foreign_key: 'provider_id', dependent: :nullify

  # validations
  validates_presence_of :name, :email, :password_digest
end
