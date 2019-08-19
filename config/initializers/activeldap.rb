require 'active_ldap'
ldap_config = YAML.load(ERB.new(File.read("#{Rails.root}/config/ldap.yml")).result(binding))[Rails.env]

if ldap_config['host'] && ldap_config['base']
  options = { host: ldap_config['host'], base: ldap_config['base'],
              allow_anonymous: false, try_sasl: false }
end

if options 
  options[:port] = ldap_config['port'] if ldap_config['port']
  options[:bind_dn] = ldap_config['admin_user'] if ldap_config['admin_user']
  options[:password_block] = Proc.new { ldap_config['admin_password'] } if ldap_config['admin_password']
  ActiveLdap::Base.setup_connection(options)
end
