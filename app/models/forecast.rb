class Forecast
  attr_accessor :date, :temp_low, :temp_high, :description

  def initialize(date, temp_low, temp_high, description)
    @date = date
    @temp_low = temp_low
    @temp_high = temp_high
    @description = description
  end
end