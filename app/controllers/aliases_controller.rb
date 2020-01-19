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
    @alias = Alias.new
  end

  def fast_alias_creation
    pending_alias = true
    domainname = 'crta.me'
    # Create random alias into "crta.me" domain
    @alias = Alias.new(domain: Domain.find(domainname),
                       cn: "#{current_user.name} random alias",
                       maildrop: current_user.email,
                       description: "Automatically generated alias #{I18n.l(Date.today)}")
    while pending_alias
      random_part = ('a'..'z').to_a.shuffle[0,4].join
      # Check if alias exists
      pending_alias = Alias.search(filter: "mail=#{random_part}@#{domainname}").any?
    end
    @alias = Alias.create domain: Domain.find(domainname),
                          mail: "#{random_part}@#{domainname}",
                          cn: "#{current_user.name} random alias",
                          maildrop: current_user.email,
                          description: "Automatically generated alias #{I18n.l(Date.today)}"
    if @alias.errors.empty?
      redirect_to domain_aliases_path(domainname), notice: t('aliases.creation-ok')
    else
      render :fast_alias
    end
  end

  private

  def get_alias
    @alias = Alias.find params[:id], base: @domain.dn
  end

  def alias_params
    params.require(:alias).permit( :mail, :cn, :maildrop, :description )
  end

end
