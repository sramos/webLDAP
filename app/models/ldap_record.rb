class LdapRecord < ActiveLdap::Base
  self.abstract_class = true

  def self.is_admin? user_dn, domain_group_dn=nil
    domain_group_dn ||= "cn=admins_group,dc=sitiodistinto,dc=net"
    group_attribute = "member"
    return search(base: domain_group_dn,
                  filter: "(#{group_attribute}=#{user_dn})",
                  scope: :base).any?
  end

  # Not all objects have prefix, so if some of then doesnt define it, so
  # monkey patching and ignore defaults
  def self.default_prefix
    #super
  end
end
