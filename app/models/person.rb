
class Person < LdapRecord
  include Dominable
  @@prefix = 'ou=People'

  ldap_mapping dn_attribute: 'cn',
               classes: ['top', 'person', 'inetOrgPerson'],
               scope: :sub
end
