class PeopleController < ApplicationController
  before_action :get_domain
  before_action :get_person, only: [:show, :edit, :update, :destroy]

  # GET /domains/domainname/people
  def index
    @current_page = t('domains.people')
    @people = @domain.people
  end

  # GET /domains/domainname/people/1
  def show
    @current_page = @person.id
  end

  # GET /domains/domainname/people/new
  def new
    @current_page = t('people.actions.new')
  end

  # GET /domains/domainname/people/1/edit
  def edit
    @current_page = t('people.actions.edit')%[@person.id]
  end

  # POST /domains/domainname/people/1
  def create
  end

  # PUT /domains/domainname/people/1
  def update
  end

  # DELETE /domains/domainname/people/1
  def destroy
  end

  private

  def get_domain
    @domain = Domain.find params[:domain_id]
  end

  def get_person
    @person = Person.find params[:id], base: @domain.dn
  end

  def person_params
  end

end
