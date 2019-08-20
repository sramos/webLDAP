
class Domain < LdapRecord
  ldap_mapping :dn_attribute => 'o',
               :prefix => 'ou=Domains', :classes => ['top', 'organization', 'domainRelatedObject'],
               :scope => :one

  # Return all mail accounts of the domain
  def people
    people_array.collect do |o|
      Person.find o[1][Person.dn_attribute][0], base: self.dn
    end
  end
  def people_array
    Person.search base: self.dn
  end
  # Return all mail alias of the domain
  def aliases
    aliases_array.collect do |o|
      Alias.find o[1][Alias.dn_attribute][0], base: self.dn
    end
  end
  def aliases_array
    Alias.search base: self.dn
  end

end
