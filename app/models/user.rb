class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :ldap_authenticatable,
         :rememberable, :trackable, :timeoutable

  # Before create a new user, get more info from LDAP
  def ldap_before_save
    name_param = ENV['LDAP_ATTRIB_NAME']||'sn'
    self.name = Devise::LDAP::Adapter.get_ldap_param(self.email, name_param).first
  end

  # Change password in LDAP
  def update_password params
    valid_password = valid_ldap_authentication?(params[:password_current]) unless params[:password_current].blank?
    # Validate user password
    if !valid_password
      self.errors.add :base, I18n.t("errors.user.password_invalid")
    # Check if new password matches with confirmation
    elsif params[:password_new] != params[:password_confirm] || params[:password_new].blank?
      self.errors.add :base, I18n.t("errors.user.passwords_dont_match")
    # Change password
    else
      self.password = params[:password_new]
      self.change_password! params[:password_current]
    end
  end

end
