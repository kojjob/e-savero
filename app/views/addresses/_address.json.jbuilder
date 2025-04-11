json.extract! address, :id, :street, :city, :state, :postal_code, :country, :user_id, :address_type, :created_at, :updated_at
json.url address_url(address, format: :json)
