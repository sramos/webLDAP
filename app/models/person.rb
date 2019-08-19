
class Person < LdapRecord
  ldap_mapping :dn_attribute => 'cn',
               :prefix => 'ou=Domains', :classes => ['top', 'person', 'inetOrgPerson'],
               :scope => :sub
end
