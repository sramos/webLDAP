
class Alias < LdapRecord
  include Dominable

  ldap_mapping dn_attribute: 'mail',
               prefix: 'ou=Alias', classes: ['top', 'person', 'courierMailAlias'],
               scope: :sub

  def maildrop_as_string
    self.mailDrop.class == Array ? self.mailDrop.join(", ") : self.mailDrop
  end
end
