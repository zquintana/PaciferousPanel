json.array!(@ssh_keys) do |ssh_key|
  json.extract! ssh_key, :id, :user_id, :key
  json.url ssh_key_url(ssh_key, format: :json)
end
