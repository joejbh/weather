class Forecast
  attr_accessor :date, :temp_low, :temp_high, :description, :precipitation

  def initialize(date, temp_low, temp_high, description, precipitation)
    @date = date
    @temp_low = temp_low.to_i
    @temp_high = temp_high.to_i
    @description = description
    @precipitation = precipitation.to_f
  end
end