require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "/locations", type: :request do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  let(:valid_attributes) {
    {
      address: 'address',
      city: 'city',
      state: 'VA',
      zip: '88333',
    }
    {
      city: 'city',
      state: 'VA',
      zip: '88333',
    }
  }

  let(:invalid_attributes) {
    {
      address: 'address',
      city: nil,
      state: 'VA',
      zip: '88333',
    }
    {
      address: 'address',
      city: 'city',
      state: nil,
      zip: '88333',
    }
    {
      address: 'address',
      city: 'city',
      state: 'VA',
      zip: nil,
    }
    {
      address: 'address',
      city: 'city',
      state: 'VA',
      zip: '111',
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      r = make_mock_weather_response("2023-03-2", 44, 77, "nice", 0.95)

      stub_weather_request(valid_attributes[:zip], [r])

      Location.create! valid_attributes
      get locations_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_location_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Location" do
        expect {
          post locations_url, params: { location: valid_attributes }
        }.to change(Location, :count).by(1)
      end

      it "redirects to the locations list" do
        post locations_url, params: { location: valid_attributes }
        expect(response).to redirect_to(locations_url)
      end
    end

    context "with only an ip address" do
      it "creates a new Location after fetching address data" do
        response = make_mock_address_response("Sample City", "myState", "33333")
        ip_address = "22.22.22.22"

        stub_address_request(ip_address, response)

        expect {
          post locations_url, params: { location: { ip_address: ip_address } }
        }.to change(Location, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Location" do
        expect {
          post locations_url, params: { location: invalid_attributes }
        }.to change(Location, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post locations_url, params: { location: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  context "with invalid ip address" do
    it 'should not create a new Location' do
      ip_address = "1111.1.1.1"

      invalid_response = {
        ip: ip_address,
        error: true,
        reason: "Invalid IP Address"
      }

      stub_address_request(ip_address, invalid_response)

      expect {
        post locations_url, params: { location: { ip_address: ip_address } }
      }.to change(Location, :count).by(0)

    end
  end

  describe "DELETE /destroy" do
    before do
      r = make_mock_weather_response("2023-03-2", 44, 77, "nice", 0.95)

      stub_weather_request(valid_attributes[:zip], [r])
    end

    it "destroys the requested location" do
      location = Location.create! valid_attributes

      expect {
        delete location_url(location)
      }.to change(Location, :count).by(-1)
    end

    it "redirects to the locations list" do
      location = Location.create! valid_attributes

      delete location_url(location)
      expect(response).to redirect_to(locations_url)
    end
  end
end
