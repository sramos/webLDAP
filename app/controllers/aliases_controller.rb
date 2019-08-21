class AliasesController < ApplicationController
  before_action :get_alias, only: [:show, :edit, :update, :destroy]

  # GET /domains/domainname/aliases
  def index
    @aliases = @domain.aliases
  end

  # GET /domains/domainname/aliases/1
  def show
  end

  # GET /domains/domainname/aliases/new
  def new
    @alias = Alias.new
  end

  # GET /domains/domainname/aliases/1/edit
  def edit
  end

  # POST /domains/domainname/aliases/1
  def create
    @alias = Alias.new(alias_params)
    @alias.domain = @domain
    if @alias.save
      redirect_to domain_aliases_path(@domain), notice: t('aliases.creation-ok')
    else
      render :new
    end
  end

  # PUT /domains/domainname/aliases/1
  def update
    if @alias.update(alias_params)
      redirect_to domain_aliases_path(@domain), notice: t('aliases.edition-ok')
    else
      render :edit
    end
  end

  # DELETE /domains/domainname/aliases/1
  def destroy
    if @alias.destroy
      redirect_to domain_aliases_path(@domain), notice: t('aliases.deletion-ok')
    else
      render :edit
    end
  end

  private

  def get_alias
    @alias = Alias.find params[:id], base: @domain.dn
  end

  def alias_params
    # ActiveLdap doesnt support ActionController::Parameters
    params.require(:alias).permit( :mail, :cn, :maildrop ).to_hash
  end

end
