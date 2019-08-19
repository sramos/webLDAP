class HomeController < ApplicationController
  def index
  end

  def edit_password
    es_admin = current_user.is_global_admin?
    puts "El usuario SI es administrador global" if es_admin
    puts "El usuario NO es administrador global" unless es_admin
  end

  def update_password
    current_user.update_password params
    puts current_user.errors.inspect
    render (current_user.errors.blank? ? :index : :edit_password)
  end
end
