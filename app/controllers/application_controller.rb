class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :get_related_domain

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end

  # Get domain from params and check that current user can read it
  def get_related_domain
    if params[:domain_id] && current_user
      if related_domain = Domain.find(params[:domain_id])
        @domain = related_domain if current_user.is_global_admin? || current_user.is_domain_admin?(related_domain.dn.to_s)
      end
    end
  end
end
