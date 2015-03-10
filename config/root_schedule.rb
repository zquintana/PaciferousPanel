
every 5.minutes do
	rake "nix:process_users"
	rake "nix:process_keys"
	rake "host:add_vhosts"
end