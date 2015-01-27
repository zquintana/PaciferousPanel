json.array!(@domains) do |domain|
  json.extract! domain, :id, :name, :alias, :user_id, :status, :ip_id
  json.url domain_url(domain, format: :json)
end
