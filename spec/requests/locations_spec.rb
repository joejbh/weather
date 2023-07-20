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
      r = ({ data: [
        { datetime: "2023-03-2", low_temp: "44", high_temp: "77", weather: { description: "nice" } },
      ] }).to_json

      stub_request(:get, "https://api.weatherbit.io/v2.0/forecast/daily?key=&postal_code=#{valid_attributes[:zip]}&units=I").
        to_return(status: 200, body: r, headers: {})

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
        response = ({ city: "Sample City", region: "myState", postal: "33333" }).to_json
        ip_address = "22.22.22.22"

        stub_request(:get, "https://ipapi.co/#{ip_address}/json/")
          .to_return(status: 200,
                     body: response)

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

      response = ({
        ip: ip_address,
        error: true,
        reason: "Invalid IP Address"
      }
      ).to_json

      stub_request(:get, "https://ipapi.co/#{ip_address}/json/")
        .to_return(status: 200,
                   body: response)
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested location" do
      r = ({ data: [
        { datetime: "2023-03-2", low_temp: "44", high_temp: "77", weather: { description: "nice" } },
      ] }).to_json

      stub_request(:get, "https://api.weatherbit.io/v2.0/forecast/daily?key=&postal_code=#{valid_attributes[:zip]}&units=I").
        to_return(status: 200, body: r, headers: {})

      location = Location.create! valid_attributes
      expect {
        delete location_url(location)
      }.to change(Location, :count).by(-1)
    end

    it "redirects to the locations list" do
      r = ({ data: [
        { datetime: "2023-03-2", low_temp: "44", high_temp: "77", weather: { description: "nice" } },
      ] }).to_json

      stub_request(:get, "https://api.weatherbit.io/v2.0/forecast/daily?key=&postal_code=#{valid_attributes[:zip]}&units=I").
        to_return(status: 200, body: r, headers: {})

      location = Location.create! valid_attributes
      delete location_url(location)
      expect(response).to redirect_to(locations_url)
    end
  end
end
