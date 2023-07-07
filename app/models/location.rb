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
end
