require 'active_ldap'
ldap_config = YAML.load(ERB.new(File.read("#{Rails.root}/config/ldap.yml")).result(binding))[Rails.env]
ActiveLdap::Base.setup_connection(
  host: ldap_config['host'],
  port: ldap_config['port'],
  base: ldap_config['base'],
  #:logger => logger_object,
  bind_dn: ldap_config['admin_user'],
  password_block: Proc.new { ldap_config['admin_password'] },
  allow_anonymous: false,
  try_sasl: false
)
