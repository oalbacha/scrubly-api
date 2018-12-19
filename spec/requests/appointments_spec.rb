require 'rails_helper'

RSpec.describe 'Appointment API', type: :request do
  let(:user) { create(:user) }
  # Initialize the test data
  let!(:patient) { create(:patient) }
  let!(:appointments) { create_list(:appointment, 5, patient: patient) }
  let(:patient_id) { patient.id }
  let(:id) { appointments.first.id }
  let(:headers) { valid_headers }
  let(:endpoint) { "http://example.com/" }

  describe 'GET index' do
    before { get "/patients/#{patient_id}/appointments", params: {}, headers: headers }


    context 'when patient exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all patient appointments' do
        expect(json.size).to eq(5)
      end
    end

    context 'when patient does not exist' do
      let(:patient_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Patient/)
      end
    end
  end


  # Test suite for GET /patients/:patient_id/appointments/:id
  describe 'GET /patients/:patient_id/appointments/:id' do
    before { get "/patients/#{patient_id}/appointments/#{id}", params: {}, headers: headers }

    context 'when patient appointment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the appointment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when patient appointment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end

  # Test suite for PUT /patients/:patient_id/appointments
  describe 'POST /patients/:patient_id/appointments' do
    let(:valid_attributes) { { title: 'Consultation' }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/patients/#{patient_id}/appointments", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end


    context 'when an invalid request' do
      before { post "/patients/#{patient_id}/appointments", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /patients/:patient_id/appointments/:id
  describe 'PUT /patients/:patient_id/appointments/:id' do
    let(:valid_attributes) { { title: 'SkinClinic' }.to_json }

    before do
      put "/patients/#{patient_id}/appointments/#{id}", params: valid_attributes, headers: headers
    end

    context 'when appointment exists' do
      it 'returns status 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the appointment' do
        updated_appointment = Appointment.find(id)
        expect(updated_appointment.title).to match(/SkinClinic/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end

  # Test suite for DELETE /patients/:id
  describe 'DELETE /patients/:id' do
    before { delete "/patients/#{patient_id}/appointments/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end