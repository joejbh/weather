class AddressService
  def get_by_ip_address(ip_address)
    resp = Net::HTTP.get(URI("https://ipapi.co/#{ip_address}/json/"))

    loc = JSON.parse(resp)

    Location.new(city: loc["city"], state: loc["region"], zip: loc["postal"], ip_address: ip_address)
  end
end