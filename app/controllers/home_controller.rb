class HomeController < ApplicationController
  def index
  end

  def edit_password
  end

  def update_password
    current_user.update_password params
    puts current_user.errors.inspect
    render (current_user.errors.blank? ? :index : :edit_password)
  end
end
