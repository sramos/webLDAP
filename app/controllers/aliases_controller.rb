class AliasesController < ApplicationController
  before_action :get_domain
  before_action :get_alias, only: [:show, :edit, :update, :destroy]

  # GET /domains/domainname/aliases
  def index
    @current_page = t('domains.mail-aliases')
    @aliases = @domain.aliases
  end

  # GET /domains/domainname/aliases/1
  def show
    @current_page = @alias.id
  end

  # GET /domains/domainname/aliases/new
  def new
    @current_page = t('aliases.actions.new')
  end

  # GET /domains/domainname/aliases/1/edit
  def edit
    @current_page = t('aliases.actions.edit')%[@alias.id]
  end

  # POST /domains/domainname/aliases/1
  def create
  end

  # PUT /domains/domainname/aliases/1
  def update
  end

  # DELETE /domains/domainname/aliases/1
  def destroy
  end

  private

  def get_domain
    @domain = Domain.find params[:domain_id]
  end

  def get_alias
    @alias = Alias.find params[:id], base: @domain.dn
  end

  def alias_params
  end

end
