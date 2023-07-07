class WeatherService
  def get_forecasts_by_zip(zip)
    resp = Net::HTTP.get(
      URI(
        "https://api.weatherbit.io/v2.0/forecast/daily?postal_code=#{zip}&units=I&key=#{ENV["WEATHER_BIT_KEY"]}"))
    parsed = JSON.parse(resp)

    parsed["data"].map do |f|
      Forecast.new(f["datetime"], f["low_temp"], f["high_temp"], f["weather"]["description"])
    end

    #   Forecast.new("2023-03-2", "44", "77", "Nice"),
    #   Forecast.new("2023-03-3", "55", "66", "Nice"),
    #   Forecast.new("2023-03-4", "77", "88", "Nice")]
  end
end