require "resolv"

class Location < ApplicationRecord
  validates :city, :state, :zip, presence: true

  validates_format_of :zip,
                      with: /\A\d{5}\z/,
                      message: "should be in a 5 number format",
                      allow_blank: false

  validates :ip_address,
            format: {
              with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex)
            },
            allow_blank: true

  attr_accessor :forecasts

  after_find :after_find
  before_validation :before_validation

  private

  def after_find
    if !self.zip.blank?
      self.forecasts = WeatherService.new.get_forecasts_by_zip self.zip
    end
  end

  def before_validation
    if !self.ip_address.blank?
      l = AddressService.new.get_by_ip_address(self.ip_address)
      self.address = l.address
      self.city = l.city
      self.state = l.state
      self.zip = l.zip
    end
  end
end
