
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

  private

  # Check if alias mail belongs to own domain
  def check_email_domain
    unless mail.match("^[^@]+@#{domain.id}$")
      errors.add(:base, I18n.t('errors.alias.mail-domain')%[mail,domain.id])
    end
  end
end
