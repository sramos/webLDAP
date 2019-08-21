
class Person < LdapRecord
  PREFIX = "ou=People"
  include Dominable

  ldap_mapping dn_attribute: 'cn',
               classes: ['top', 'person', 'inetOrgPerson'],
               scope: :sub
end
