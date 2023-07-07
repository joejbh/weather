require 'rails_helper'

RSpec.describe "/locations", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # Location. As you add validations to Location, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      address: 'address',
      city: 'city',
      state: 'VA',
      zip: '88333',
      ip_address: '2.2.2.2'
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
      ip_address: '2.2.2.2'
    }
    {
      address: 'address',
      city: 'city',
      state: nil,
      zip: '88333',
      ip_address: '2.2.2.2'
    }
    {
      address: 'address',
      city: 'city',
      state: 'VA',
      zip: nil,
      ip_address: '2.2.2.2'
    }
    {
      address: 'address',
      city: 'city',
      state: 'VA',
      zip: '111',
      ip_address: '2.2.2.2'
    }
    {
      address: 'address',
      city: 'city',
      state: 'VA',
      zip: '88333',
      ip_address: '1111.1.1.1'
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
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

  describe "DELETE /destroy" do
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
