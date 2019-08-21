
class Alias < LdapRecord
  include Dominable
  @@prefix = 'ou=Alias'

  ldap_mapping dn_attribute: 'mail',
               classes: ['top', 'person', 'courierMailAlias'],
               scope: :sub

  def maildrop_as_string
    self.mailDrop.class == Array ? self.mailDrop.join(", ") : self.mailDrop
  end
end
