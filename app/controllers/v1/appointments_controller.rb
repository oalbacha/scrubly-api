module V1
  class AppointmentsController < ApplicationController
    before_action :set_patient
    before_action :set_patient_appointment, only: [:show, :update, :destroy]

    # GET /patients/:patint_id/appointments
    def index
      json_response(@patient.appointments)
    end

    # GET /patients/:patint_id/appointments/:id
    def show
      json_response(@appointment)
    end

    # POST /patients/:patient_id/items
    def create
      @patient.appointments.create!(appointment_params)
      json_response(@patient, :created)
    end

    # PUT /patients/:patient_id/items/:id
    def update
      @appointment.update(appointment_params)
      head :no_content
    end

    # DELETE /patients/:patient_id/items/:id
    def destroy
      @appointment.destroy
      head :no_content
    end


    private

    def appointment_params
      params.permit(:title)
    end

    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

    def set_patient_appointment
      @appointment = @patient.appointments.find_by!(id: params[:id]) if @patient
    end
  end
end
