require 'erubis'

TPL_DIR = "#{Rails.root}/lib/tpls"

def render(fname, context)
  tpl = Erubis::Eruby.new(File.read(File.join(TPL_DIR, "#{fname}.eruby")))
  tpl.evaluate(context)
end

namespace :host do
	desc "Add pending vhosts to sites-available and reset apache"
	task :add_vhosts => :environment do
    # context = {
    #  ip: '*',
    #  vhost_root: '/home/zach/www',
    #  server_admin: 'zach.quintana@gmail.com',
    #  server_name: 'zachquintana.com'
    # }

		# puts "#{render('vhost', context)}"

    vhost_root = Setting.get('virtual_hosts_path')
    def create_context(domain, vhost_root)
      {
        ip: domain.ip.address,
        vhost_root: vhost_root,
        server_admin: Setting.get('server_admin'),
        server_name: domain.name,
        server_alias: domain.alias ? domain.alias : nil
      }
    end

    puts "Starting vhost updates"
    Domain.transaction do
      Domain.all_pending.each do |domain|
        puts "Updating #{domain.name}"
        conf_path = File.join(vhost_root, "#{domain.name}.conf")
        
        File.open conf_path, 'w' do |file|
          file.write render('vhost', create_context(domain, vhost_root))
        end

        domain.status = Domain.EnabledStatusType
        domain.save
      end
    end
    puts "Done updating vhosts"

    if Setting.get('debug') == false
      sh "service apache2 restart"
    end
	end
end