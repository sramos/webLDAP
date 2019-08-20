
class Domain < LdapRecord
  ldap_mapping :dn_attribute => 'o',
               :prefix => 'ou=Domains', :classes => ['top', 'organization', 'domainRelatedObject'],
               :scope => :one

  # Return all mail accounts of the domain
  def people
    Person.find base: self.dn
  end
  # Return all mail alias of the domain
  def aliases
    Alias.find base: self.dn
  end

end
