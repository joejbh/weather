require "rails_helper"

RSpec.describe LocationsController, type: :routing do
  describe "routing" do
    it "routes to #index for root" do
      expect(get: "/").to route_to("locations#index")
    end

    it "routes to #index" do
      expect(get: "/locations").to route_to("locations#index")
    end

    it "routes to #new" do
      expect(get: "/locations/new").to route_to("locations#new")
    end

    it "routes to #create" do
      expect(post: "/locations").to route_to("locations#create")
    end

    it "routes to #destroy" do
      expect(delete: "/locations/1").to route_to("locations#destroy", id: "1")
    end
  end
end
