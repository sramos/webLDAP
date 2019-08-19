
class Person < LdapRecord
  ldap_mapping :dn_attribute => 'cn',
               :prefix => 'ou=People', :classes => ['top', 'person', 'inetOrgPerson'],
               :scope => :one
end
