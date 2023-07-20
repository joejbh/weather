class WeatherService
  def get_forecasts_by_zip(zip)
    resp = Net::HTTP.get(
      URI(
        "https://api.weatherbit.io/v2.0/forecast/daily?postal_code=#{zip}&units=I&key=#{ENV["WEATHER_BIT_KEY"]}"))
    parsed = JSON.parse(resp)

    parsed["data"].slice(0, 7).map do |f|
      Forecast.new(f["datetime"], f["low_temp"], f["high_temp"], f["weather"]["description"], f["precip"])
    end
  end
end