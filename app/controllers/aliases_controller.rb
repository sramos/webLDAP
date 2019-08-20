class AliasesController < ApplicationController
  before_action :get_alias, only: [:show, :edit, :update, :destroy]

  # GET /domains/domainname/aliases
  def index
  end

  # GET /domains/domainname/aliases/1
  def show
  end

  # GET /domains/domainname/aliases/new
  def new
  end

  # GET /domains/domainname/aliases/1/edit
  def edit
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

  def get_alias
  end

  def alias_params
  end

end
