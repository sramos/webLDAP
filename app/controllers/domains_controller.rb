class DomainsController < ApplicationController
  # GET /domains
  def index
    @domains = []
    # If current user is global admin, get all domains
    Domain.all.each do |domain|
      is_admin = current_user.is_global_admin? || current_user.is_domain_admin?(domain.dn.to_s)
      @domains.push domain if is_admin
    end
  end

  # GET /domains/1
  def show
  end

  # GET /domains/new
  def new
  end

  # GET /domains/1/edit
  def edit
  end

  # POST /domains/1
  def create
  end

  # PUT /domains/1
  def update
  end

  # DELETE /domains/1
  def destroy
  end

  private

  def domain_params
  end

end