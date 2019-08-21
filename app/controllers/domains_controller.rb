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
  end

  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # GET /domains/1/edit
  def edit
  end

  # POST /domains/1
  def create
    @domain = Domain.new(domain_params)
    if @domain.save
      redirect_to domains_path, notice: t('domains.creation-ok')
    else
      render :new
    end
  end

  # PUT /domains/1
  def update
    if @domain.update(domain_params)
      redirect_to domains_path, notice: t('domains.edition-ok')
    else
      render :edit
    end
  end

  # DELETE /domains/1
  def destroy
    if @domain.destroy
      redirect_to domains_path, notice: t('aliases.deletion-ok')
    else
      render :edit
    end
  end

  private

  def get_domain
    @domain = Domain.find params[:id]
  end

  def domain_params
    # ActiveLdap doesnt support ActionController::Parameters
    params.require(:domain).permit( :o, :associateddomain,
                                    :destinationindicator, :description ).to_hash
  end

end
