
class Domain < LdapRecord
  ldap_mapping :dn_attribute => 'o',
               :prefix => 'ou=Domains', :classes => ['top', 'organization', 'domainRelatedObject'],
               :scope => :one
end
