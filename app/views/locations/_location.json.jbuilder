json.extract! location, :id, :address, :city, :state, :zip, :ip_address, :created_at, :updated_at
json.url location_url(location, format: :json)
