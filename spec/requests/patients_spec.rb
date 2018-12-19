require 'rails_helper'

RSpec.describe 'Patients API', type: :request do
  # add patients owner
  let(:user) { create(:user) }
  # initialize test data
  let!(:patients) { create_list(:patient, 10,  provider_id: user.id) }
  let(:patient_id) { patients.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /patients
  describe 'GET /patients' do
    # make HTTP get request before each example
    before { get '/patients', params: {}, headers: headers }

    it 'returns patients' do
      # Note 'json' is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /patients/:id
  describe 'GET /patients/:id' do
    before { get "/patients/#{patient_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the patient' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(patient_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:patient_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Patient/)
      end
    end
  end

  # Test suite for POST /patients
  describe 'POST /patients' do
    # valid payload
    let(:valid_attributes) do
      { first_name: 'John', phone: '7155551234' }.to_json
    end

    context 'when the request is valid' do
      before { post '/patients', params: valid_attributes, headers: headers }

      it 'creates a patient' do
        expect(json['first_name']).to eq('John')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { first_name: nil }.to_json }
      before { post '/patients', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to include("Phone can't be blank")
        expect(json['message']).to include("First name can't be blank")
      end
    end
  end

  # Test suite for PUT /patients/:id
  describe 'PUT /patients/:id' do
    let(:valid_attributes) { { name: 'Marc Jeff' }.to_json }

    context 'when the record exists' do
      before { put "/patients/#{patient_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /patients/:id
  describe 'DELETE /patients/:id' do
    before { delete "/patients/#{patient_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end