
class Alias < LdapRecord
  PREFIX = 'ou=Alias'
  include Dominable

  ldap_mapping dn_attribute: 'mail',
               classes: ['top', 'person', 'courierMailAlias'],
               scope: :sub

  before_validation(on: :create) do
    self.description = self.mail if self.description.blank?
    self.sn = self.id if self.sn.blank?
  end
  before_validation do
    user_match = mail.match("^([^@]+)@#{domain.id}$")
    self.cn = (user_match ? user_match[1] : "invalid") if self.cn.blank?
  end

  validate :check_email_domain

  def maildrop_as_string
    self.mailDrop.class == Array ? self.mailDrop.join(", ") : self.mailDrop
  end

  def self.create_random_alias user, domainname
    pending_alias = true
    # Create random alias into "crta.me" domain
    while pending_alias
      random_part = ('a'..'z').to_a.shuffle[0,4].join
      # Check if alias exists
      pending_alias = Alias.search(filter: "mail=#{random_part}@#{domainname}").any?
    end
    # This has to be done by any admin, not by current user
    return Alias.create(domain: Domain.find(domainname),
                        mail: "#{random_part}@#{domainname}",
                        cn: "#{user.name} random alias",
                        maildrop: user.email,
                        description: "Automatically generated alias #{I18n.l(Date.today)}")
  end

  private

  # Check if alias mail belongs to own domain
  def check_email_domain
    unless mail.match("^[^@]+@#{domain.id}$")
      errors.add(:base, I18n.t('errors.alias.mail-domain')%[mail,domain.id])
    end
  end
end
