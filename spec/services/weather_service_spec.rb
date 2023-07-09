require "rails_helper"

RSpec.describe WeatherService do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  describe "get_forecasts_by_zip" do
    it "should map correctly" do
      r = ({ data: [
        { datetime: "2023-03-2", low_temp: "44", high_temp: "77", weather: { description: "nice" } },
      ] }).to_json

      stub_request(:get, "https://api.weatherbit.io/v2.0/forecast/daily?key=&postal_code=#{11111}&units=I").
        to_return(status: 200, body: r, headers: {})

      actual = WeatherService.new().get_forecasts_by_zip(11111)
      expected = [Forecast.new("2023-03-2", "44", "77", "nice")]

      expect(actual.to_json).to eq(expected.to_json)
    end

    it "only return the first 7 forecasts given 8 forecasts" do
      api_forecast = { datetime: "2023-03-2", low_temp: "44", high_temp: "77", weather: { description: "nice" } }

      r = ({
        data: [api_forecast] * 16
      }).to_json

      stub_request(:get, "https://api.weatherbit.io/v2.0/forecast/daily?key=&postal_code=#{11111}&units=I").
        to_return(status: 200, body: r, headers: {})

      actual = WeatherService.new().get_forecasts_by_zip(11111)

      expect(actual.length).to eq(7)
    end
  end
end