json.array!(@ips) do |ip|
  json.extract! ip, :id, :address
  json.url ip_url(ip, format: :json)
end
