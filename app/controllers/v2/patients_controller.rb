class V2::PatientsController < ApplicationController
  def index
    json_response({ message: 'Hello there' })
  end
end
