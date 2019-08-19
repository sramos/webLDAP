
class Alias < LdapRecord
  ldap_mapping :dn_attribute => 'mail',
               :prefix => 'ou=Domains', :classes => ['top', 'person', 'courierMailAlias'],
               :scope => :sub
end
