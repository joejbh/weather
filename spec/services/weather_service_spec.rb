require "rails_helper"

RSpec.describe WeatherService do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  describe "get_forecasts_by_zip" do
    it "should map correctly" do
      r = make_mock_weather_response("2023-03-2", 44, 77, "nice", 0.95)

      zip = 11111
      stub_weather_request(zip, [r])

      actual = WeatherService.new.get_forecasts_by_zip(zip)
      expected = [Forecast.new("2023-03-2", 44, 77, "nice", 0.95)]

      expect(actual.to_json).to eq(expected.to_json)
    end

    it "only return the first 7 forecasts given 8 forecasts" do
      r = make_mock_weather_response("2023-03-2", 44, 77, "nice", 0.95)

      zip = 11111
      stub_weather_request(zip, [r] * 8)

      actual = WeatherService.new.get_forecasts_by_zip(zip)

      expect(actual.length).to eq(7)
    end
  end
end