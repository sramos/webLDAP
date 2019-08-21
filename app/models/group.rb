
class Group < LdapRecord
  include Dominable
  @@prefix = 'ou=Group'

  ldap_mapping dn_attribute: 'cn',
               classes: ['groupOfNames'],
               scope: :sub

  def member_as_string
    self.member
  end
end
