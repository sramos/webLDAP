
class Domain < LdapRecord
  ldap_mapping dn_attribute: 'o',
               prefix: 'ou=Domains', classes: ['top', 'organization', 'domainRelatedObject'],
               scope: :one

  # Create domain structure for people, aliases and groups
  after_create :create_domain_tree

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

  # Build the full domain tree
  def create_domain_tree
    OrganizationalUnit.create ou: "Alias", domain: self
    OrganizationalUnit.create ou: "People", domain: self
    OrganizationalUnit.create ou: "Groups", domain: self
    # And the default groups
    #Group.create cn: "domain_admins", member: [current_user.ldap_dn], domain: self
  end
end
