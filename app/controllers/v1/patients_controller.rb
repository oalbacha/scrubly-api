module V1
  class PatientsController < ApplicationController
    before_action :set_patient, only: [:show, :update, :destroy]

    # GET /patients
    def index
      @patients = current_user.patients.paginate(page: params[:page], per_page: 20)
      json_response(@patients)
    end

    # POST /patients
    def create
      @patient = current_user.patients.create!(patient_params)
      json_response(@patient, :created)
    end

    # GET /todos/:id
    def show
      json_response(@patient)
    end

    # PUT /todos/:id
    def update
      @patient.update(patient_params)
      head :no_content
    end

    # DELETE /todos/:id
    def destroy
      @patient.destroy
      head :no_content
    end

    private

    def patient_params
      # whitelist params
      params.permit(:first_name, :phone)
    end

    def set_patient
      @patient = Patient.find(params[:id])
    end
  end
end