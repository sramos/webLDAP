class DomainsController < ApplicationController
  before_action :get_domain, only: [:show, :edit, :update, :destroy]

  # GET /domains
  def index
    @current_page = t('domains.menu-title')
    @domains = []
    # If current user is global admin, get all domains
    Domain.all.each do |domain|
      if current_user.is_global_admin? || current_user.is_domain_admin?(domain.dn.to_s)
        @domains.push domain
      end
    end
  end

  # GET /domains/1
  def show
    @current_page = @domain.id
  end

  # GET /domains/new
  def new
    @current_page = t('domains.actions.new')
  end

  # GET /domains/1/edit
  def edit
    @current_page = t('domains.actions.edit')%[@domain.o]
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

  def get_domain
    @domain = Domain.find params[:id]
  end

  def domain_params
  end

end
