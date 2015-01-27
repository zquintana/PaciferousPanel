json.array!(@emails) do |email|
  json.extract! email, :id, :domain_id, :password, :email
  json.url email_url(email, format: :json)
end
