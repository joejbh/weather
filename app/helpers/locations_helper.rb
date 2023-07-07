module LocationsHelper
  def convert_for_line_chart(forecasts)
    low_data = {}
    high_data = {}

    forecasts.each do |forecast|
      low_data[forecast.date] = forecast.temp_low.to_i
      high_data[forecast.date] = forecast.temp_high.to_i
    end

    [
      { name: "Low", data: low_data },
      { name: "High", data: high_data }
    ]
  end
end
