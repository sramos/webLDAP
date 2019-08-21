
class Domain < LdapRecord
  ldap_mapping dn_attribute: 'o',
               prefix: 'ou=Domains', classes: ['top', 'organization', 'domainRelatedObject'],
               scope: :one

  # Return all mail accounts of the domain
  def people
    Person.all base: dn
  end
  # Return all mail alias of the domain
  def aliases
    Alias.all base: dn
  end
  # Return all groups of the domain
  def groups
    Group.all base: dn
  end
end
