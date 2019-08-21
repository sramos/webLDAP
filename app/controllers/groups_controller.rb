class GroupsController < ApplicationController
  before_action :get_group, only: [:show, :edit, :update, :destroy]

  # GET /domains/domainname/groups
  def index
    @groups = @domain.groups
  end

  # GET /domains/domainname/groups/1
  def show
  end

  # GET /domains/domainname/groups/new
  def new
    @group = Group.new
  end

  # GET /domains/domainname/groups/1/edit
  def edit
  end

  # POST /domains/domainname/groups/1
  def create
    @group = Group.new(group_params)
    @group.domain = @domain
    if @group.save
      redirect_to domain_groups_path(@domain), notice: t('groups.creation-ok')
    else
      render :new
    end
  end

  # PUT /domains/domainname/aliases/1
  def update
    if @group.update(alias_params)
      redirect_to domain_groups_path(@domain), notice: t('groups.edition-ok')
    else
      render :edit
    end
  end

  # DELETE /domains/domainname/aliases/1
  def destroy
    if @group.destroy
      redirect_to domain_groups_path(@domain), notice: t('group.deletion-ok')
    else
      render :edit
    end
  end

  private

  def get_group
    @group = Group.find params[:id], base: @domain.dn
  end

  def group_params
    # ActiveLdap doesnt support ActionController::Parameters
    params.require(:group).permit( :cn, :description ).to_hash
  end

end
