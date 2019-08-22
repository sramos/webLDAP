class OrganizationalUnit < LdapRecord
  PREFIX = nil
  include Dominable
  ldap_mapping dn_attribute: 'ou',
               classes: ["organizationalUnit"],
               scope: :one
end
