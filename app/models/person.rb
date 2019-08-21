
class Person < LdapRecord
  include Dominable

  ldap_mapping :dn_attribute => 'cn',
               :prefix => 'ou=People', :classes => ['top', 'person', 'inetOrgPerson'],
               :scope => :sub
end
