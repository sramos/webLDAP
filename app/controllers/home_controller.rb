class HomeController < ApplicationController
  def index
    get_resources
  end

  def edit_password
    @current_page = t('actions.password-title')
  end

  def update_password
    current_user.update_password params
    puts current_user.errors.inspect unless current_user.errors.empty?
    if current_user.errors.blank?
      redirect_to action: :index
    else
      render :edit_password
    end
  end

  private

  def get_resources
    @resources = [ {name: t('actions.password-title'),
                    icon: 'key', url: change_password_path},
                   {name: t('aliases.actions.fast-alias-title'),
                    icon: 'random', url: fast_alias_path},
                   {name: t('domains.menu-title'),
                    icon: 'globe-europe', url: domains_path},
                   {name: 'Webmail',      icon: 'envelope', url: 'https://correo.sitiodistinto.net/'},
                   {name: 'URL shortner', icon: 'cut', url: 'http://crta.me/'},
                   {name: 'GitLab',       icon: 'code-branch', url: 'https://gitlab.com/sanraro'},
                   {name: 'Github',       icon: 'code-branch', url: 'https://github.com/sramos'} ]
  end
end
