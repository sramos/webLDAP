class HomeController < ApplicationController
  def index
    @resources = [ {name: t('actions.password-title'),
                    icon: 'key', url: change_password_path},
                   {name: t('domains.menu-title'),
                    icon: 'globe-europe', url: domains_path},
                   {name: 'Webmail',      icon: 'envelope', url: 'https://correo.sitiodistinto.net/'},
                   {name: 'URL shortner', icon: 'cut', url: 'http://crta.me/'},
                   {name: 'GitLab',       icon: 'code-branch', url: 'https://gitlab.com/sanraro'}
                   {name: 'Github',       icon: 'code-branch', url: 'https://github.com/sramos'} ]
  end

  def edit_password
    @current_page = t('actions.password-title')
  end

  def update_password
    current_user.update_password params
    puts current_user.errors.inspect
    render (current_user.errors.blank? ? :index : :edit_password)
  end
end
