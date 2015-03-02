
every 5.minutes do
	rake "nix:process_users"
	rake "host:add_vhosts"
end