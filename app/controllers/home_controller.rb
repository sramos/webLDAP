class HomeController < ApplicationController
  def index
    @resources = [ {name: "Webmail",      icon: "envelope", url: "https://correo.sitiodistinto.net/"},
                   {name: "URL shortner", icon: "cut", url: "http://crta.me/"},
                   {name: "Github",       icon: "code-branch", url: "https://github.com/sramos"} ]
  end

  def edit_password
  end

  def update_password
    current_user.update_password params
    puts current_user.errors.inspect
    render (current_user.errors.blank? ? :index : :edit_password)
  end
end
