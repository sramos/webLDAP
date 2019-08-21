
class Group < LdapRecord
  PREFIX = "ou=Group"
  include Dominable

  ldap_mapping dn_attribute: 'cn',
               classes: ['groupOfNames'],
               scope: :sub

  def member_as_string
    self.member
  end
end
