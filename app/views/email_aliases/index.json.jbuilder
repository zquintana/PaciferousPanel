json.array!(@email_aliases) do |email_alias|
  json.extract! email_alias, :id, :domain_id, :source, :destination
  json.url email_alias_url(email_alias, format: :json)
end
