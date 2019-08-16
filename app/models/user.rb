class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :ldap_authenticatable,
         :rememberable, :validatable

  # Before create a new user, get more info from LDAP
  def ldap_before_save
    name_param = ENV['LDAP_ATTRIB_NAME']||'sn'
    self.name = Devise::LDAP::Adapter.get_ldap_param(self.email, name_param).first
  end
end
