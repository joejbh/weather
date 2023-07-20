require 'rails_helper'
RSpec.describe LocationsHelper, type: :helper do
  describe "convert_for_chart" do
    it "should correctly map" do
      forecasts = [
        Forecast.new("2023-03-2", 44, 77, "Nice", 0.70),
        Forecast.new("2023-03-3", 55, 66, "Nice", 0),
        Forecast.new("2023-03-4", 77, 88, "Nice", 0)]

      expected = [
        { name: "Low", data: { "2023-03-2" => 44, "2023-03-3" => 55, "2023-03-4" => 77 } },
        { name: "High", data: { "2023-03-2" => 77, "2023-03-3" => 66, "2023-03-4" => 88 } }
      ]

      expect(helper.convert_for_line_chart forecasts).to eq(expected)
    end
  end
end
