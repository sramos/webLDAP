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
    @alias = Alias.new(domain: @domain)
    if @alias.update_attributes(alias_params)
      redirect_to domain_aliases_path(@domain), notice: t('aliases.creation-ok')
    else
      render :new
    end
  end

  # PUT /domains/domainname/aliases/1
  def update
    if @alias.update_attributes(alias_params)
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

  def fast_alias
    @current_page = t('aliases.actions.fast-alias')
    @alias = Alias.new
  end

  def fast_alias_creation
    @current_page = t('aliases.actions.fast-alias')
    @alias = Alias.create_random_alias current_user, 'crta.me'
    render :fast_alias
  end

  private

  def get_alias
    @alias = Alias.find params[:id], base: @domain.dn
  end

  def alias_params
    params.require(:alias).permit( :mail, :cn, :maildrop, :description )
  end

end
