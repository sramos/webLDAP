class PeopleController < ApplicationController
  before_action :get_person, only: [:show, :edit, :update, :destroy]

  # GET /domains/domainname/people
  def index
  end

  # GET /domains/domainname/people/1
  def show
  end

  # GET /domains/domainname/people/new
  def new
  end

  # GET /domains/domainname/people/1/edit
  def edit
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

  def get_person
  end

  def person_params
  end

end
