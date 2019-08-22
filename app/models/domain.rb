
class Domain < LdapRecord
  ldap_mapping dn_attribute: 'o',
               prefix: 'ou=Domains', classes: ['top', 'organization', 'domainRelatedObject'],
               scope: :one

  before_validation(on: :create) do
    self.destinationindicator = self.o if self.destinationindicator.blank?
    self.description = self.o if self.description.blank?
  end
  before_validation do
    self.associateddomain = self.o if self.associateddomain.blank?
  end

  # Create domain structure for people, aliases and groups
  after_create :create_domain_tree
  # Destroy domain structure before delete it
  before_destroy :can_destroy?, :destroy_domain_tree

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

  private

  # Build the full domain tree
  def create_domain_tree
    OrganizationalUnit.create ou: "Alias", domain: self
    OrganizationalUnit.create ou: "People", domain: self
    OrganizationalUnit.create ou: "Groups", domain: self
    # And the default groups
    #Group.create cn: "domain_admins", member: [current_user.ldap_dn], domain: self
  end

  # Validates if domain has no items on int and can be destroyed
  def can_destroy?
    if people.any? || aliases.any? || groups.any?
      errors.add(:base, I18n.t('errors.domain.destroy-with-items'))
    end
  end
  # Delete domain tree
  def destroy_domain_tree
    OrganizationalUnit.all(base: dn).each {|ou| ou.destroy} if errors.empty?
  end
end
