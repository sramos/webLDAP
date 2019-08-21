
class Alias < LdapRecord
  PREFIX = 'ou=Alias'
  include Dominable

  ldap_mapping dn_attribute: 'mail',
               classes: ['top', 'person', 'courierMailAlias'],
               scope: :sub

  before_validation(on: :create) do
    self.cn ||= self.id
    self.sn ||= self.cn
    self.description ||= self.cn
  end

  def maildrop_as_string
    self.mailDrop.class == Array ? self.mailDrop.join(", ") : self.mailDrop
  end
end
